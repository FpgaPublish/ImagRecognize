#ifndef UART_BLCK_H
#define UART_BLCK_H

#include <QWidget>
// --------------------------------------------
// user add lib
#include <QtSerialPort/QSerialPort>
#include <QtSerialPort/QSerialPortInfo>
namespace Ui {
class uart_blck;
}

class uart_blck : public QWidget
{
    Q_OBJECT

public:
    explicit uart_blck(QWidget *parent = nullptr);
    ~uart_blck();

private:
    Ui::uart_blck *ui;
    QSerialPort *c_serial;
    // --------------------------------------------
    // serial param
    QString s_port_bit;
    QString s_baud_bit; //baud rate
    QString s_chck_bit; //check bit
    QString s_data_bit; //data bit
    QString s_stop_bit; //stop bit
    QString s_ctrl_bit; //control stream

    int n_port_bit;
    int n_baud_bit; //baud rate
    int n_chck_bit; //check bit
    int n_data_bit; //data bit
    int n_stop_bit; //stop bit
    int n_ctrl_bit; //control stream

    // --------------------------------------------
    // add init function
    void uart_init();
    void uart_update();
    void uart_set();
signals:
    // --------------------------------------------
    // UART signals
    void    info_trig(quint32,quint32,QString,QString);
    void    spd_trig(float);
private slots:
    void on_ui_read_par_clicked();
    void on_ui_setx_par_clicked();
    void on_ui_exit_win_clicked();
    // --------------------------------------------
    // UART function
public:
    void uart_open();
private slots:
    void uart_recv_cmd();
private:
    QString s_text_temp;
};

#endif // UART_BLCK_H
