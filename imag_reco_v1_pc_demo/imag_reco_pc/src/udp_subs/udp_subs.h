#ifndef UDP_SUBS_H
#define UDP_SUBS_H

#include <QDialog>
// --------------------------------------------
// user head file
#include "../MACRO.h"
#include <QUdpSocket>
namespace Ui {
class udp_subs;
}

class udp_subs : public QDialog
{
    Q_OBJECT

public:
    explicit udp_subs(QWidget *parent = nullptr);
    ~udp_subs();

private:
    Ui::udp_subs *ui;

private:
    // --------------------------------------------
    // UDP base class
    QUdpSocket *udp_driv;
    // wait signals solve
    bool wait_signals(const unsigned int millisecond);
    //param of net
    QString s_master_ipv4;
    QString s_master_port;
    QString s_slaver_ipv4;
    QString s_slaver_port;

private slots:
    void udp_recv_blck();
    void on_buttonBox_accepted();

public:
    // --------------------------------------------
    // UDP pkg
    SUdpPck pkg_send;
    SUdpPck pkg_recv;
    void    send_udp_pkg();
public slots:
    // --------------------------------------------
    // UDP pkg demo
    void    send_udp_spd();
signals:
    // --------------------------------------------
    // UDP signals
    void    pkg_trig();
    void    info_trig(quint32,quint32,QString,QString);
    void    spd_trig(float);


};

#endif // UDP_SUBS_H
