#include "udp_subs.h"
#include "ui_udp_subs.h"

// =====================================================
// user head file
#include <QTimer>
#include <qelapsedtimer.h>
#include <QDebug>


udp_subs::udp_subs(QWidget *parent) :
    QDialog(parent),
    ui(new Ui::udp_subs)
{
    ui->setupUi(this);
    // --------------------------------------------
    // UDP base class
    udp_driv = new QUdpSocket;
    connect(udp_driv,&QUdpSocket::readyRead,this,&udp_subs::udp_recv_blck);
    // --------------------------------------------
    // UDP init param
    s_master_ipv4 = "192.168.120.11";
    s_master_port = "5001";
    s_slaver_ipv4 = "192.168.120.10";
    s_slaver_port = "5001";
    ui->ui_master_ipv4_in->setText(s_master_ipv4);
    ui->ui_master_port_in->setText(s_master_port);
    ui->ui_slaver_ipv4_in->setText(s_slaver_ipv4);
    ui->ui_slaver_port_in->setText(s_slaver_port);
    udp_driv->bind(QHostAddress(s_master_ipv4),s_master_port.toUInt());
}

udp_subs::~udp_subs()
{
    delete  udp_driv;
    delete ui;
}

bool udp_subs::wait_signals( const unsigned int millisecond)
{
    bool result = true;

    QEventLoop loop;
    connect(this,SIGNAL(pkg_trig()), &loop, SLOT(quit()));

    QTimer timer;
    timer.setSingleShot(true);
    connect(&timer, &QTimer::timeout, [&loop, &result]{ result = false; loop.quit();});
    timer.start(millisecond);
    loop.exec();
    timer.stop();
    return result;
}

void udp_subs::udp_recv_blck()
{
    //give other module solve
    emit pkg_trig();
    //solve recv data
    while(udp_driv->hasPendingDatagrams())
        {
            QByteArray ba_pkg;
            ba_pkg.resize(udp_driv->pendingDatagramSize());
            udp_driv->readDatagram(ba_pkg.data(),ba_pkg.size());
            memcpy(&pkg_recv,(SUdpPck*)ba_pkg.data(),sizeof(pkg_recv));
        }
    //qDebug() << pkg_recv.pkg_code;
}

void udp_subs::send_udp_pkg()
{
    // --------------------------------------------
    // send UDP pkg
    QByteArray ba_dat;
    ba_dat.resize(sizeof(pkg_send));
    char *pba_dat = ba_dat.data();
    memcpy(pba_dat,&pkg_send,sizeof(pkg_send));
    udp_driv->writeDatagram(ba_dat,QHostAddress(s_slaver_ipv4),s_slaver_port.toUInt());
}

void udp_subs::send_udp_spd()
{
    // --------------------------------------------
    // send speed measure
    pkg_send.pkg_code = CODE_HELLO_PS;
    pkg_send.pkg_len  = 960;
    pkg_send.pkg_wid  = 1;
    int j = 0;
    QElapsedTimer timer;
    timer.start();
    while(j < 10)
    {
        pkg_send.pkg_xor  = 0;
        for(int i = 0; i < 960; i++)
        {
            pkg_send.pkg_dat[i] = i;
            pkg_send.pkg_xor = pkg_send.pkg_xor ^ i;
        }
        send_udp_pkg();
        wait_signals(100);
        j++;
        //qDebug() << j;
    }
    float n_spd = (double)10000000000 / (double)timer.nsecsElapsed();
    //qDebug() << n_spd;
    emit spd_trig(n_spd);
}

void udp_subs::on_buttonBox_accepted()
{
    // --------------------------------------------
    // set param to Net
    s_master_ipv4 = ui->ui_master_ipv4_in->text();
    s_master_port = ui->ui_master_port_in->text();
    s_slaver_ipv4 = ui->ui_slaver_ipv4_in->text();
    s_slaver_port = ui->ui_slaver_port_in->text();
    udp_driv->bind(QHostAddress(s_master_ipv4),s_master_port.toUInt());
    QString text = "net -m_ipv4 " + s_master_ipv4 +\
                      " -m_port " + s_master_port +\
                      " -s_ipv4 " + s_slaver_ipv4 +\
                      " -s_port " + s_slaver_port;
    emit info_trig(0,CODE_NET_SET,"info",text);
}

