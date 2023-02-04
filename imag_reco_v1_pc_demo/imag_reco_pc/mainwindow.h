//////////////////////////////////////////////////////////////////////////////////
// Company: Fpga Publish
// Engineer: F
//
// Create Date: 2022 23:26:51
// Design Name:
// Module Name: mainwindow.h
// Project Name:
// Target Devices:
// Tool Versions:
// Description:
//
// Dependencies:
//
// Revision: 0.01
// Revision 0.01 - File Created
// Additional Comments:
//          1. path = D:/demo rather than D:/demo/
//////////////////////////////////////////////////////////////////////////////////
#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>

QT_BEGIN_NAMESPACE
namespace Ui { class MainWindow; }
QT_END_NAMESPACE

// =====================================================
// include subs class
#include "./src/udp_subs/udp_subs.h"
#include "./src/welcome_mdle/welcome_mdle.h"
#include "./src/uart_blck/uart_blck.h"
class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    MainWindow(QWidget *parent = nullptr);
    ~MainWindow();

private slots:
    void on_action_net_triggered();

    void on_ui_info_log_textChanged();

private:
    Ui::MainWindow *ui;
    // wait signals solve
    bool wait_signals(const char * signal, const unsigned int millisecond);
    // =====================================================
    // mesu bar param
    // --------------------------------------------
    // net param
    udp_subs *u_udp_subs;
private slots:
    void info_blck(quint32,quint32,QString,QString);
    void net_spd_driv(float);

    void on_ui_net_clicked();

private:
    // =====================================================
    // display param
    // --------------------------------------------
    // welcome display
    welcome_mdle *u_welcome_mdle;

    // =====================================================
    // uart win
    // --------------------------------------------
    // open win
    uart_blck *u_uart_blck;
private slots:
    void uart_spd_driv(float);


    void on_ui_uart_clicked();
    void on_action_uart_triggered();
    void on_ui_prot_log_textChanged();
};
#endif // MAINWINDOW_H
