/********************************************************************************
** Form generated from reading UI file 'uart_blck.ui'
**
** Created by: Qt User Interface Compiler version 5.12.11
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef UI_UART_BLCK_H
#define UI_UART_BLCK_H

#include <QtCore/QVariant>
#include <QtWidgets/QApplication>
#include <QtWidgets/QComboBox>
#include <QtWidgets/QHBoxLayout>
#include <QtWidgets/QLabel>
#include <QtWidgets/QPushButton>
#include <QtWidgets/QVBoxLayout>
#include <QtWidgets/QWidget>

QT_BEGIN_NAMESPACE

class Ui_uart_blck
{
public:
    QVBoxLayout *verticalLayout_2;
    QVBoxLayout *lay_show;
    QLabel *label_2;
    QHBoxLayout *lay_port_bit;
    QLabel *label_7;
    QComboBox *ui_port_bit;
    QHBoxLayout *lay_baud_bit;
    QLabel *label;
    QComboBox *ui_baud_bit;
    QHBoxLayout *lay_data_bit;
    QLabel *label_6;
    QComboBox *ui_data_bit;
    QHBoxLayout *lay_chck_bit;
    QLabel *label_4;
    QComboBox *ui_chck_bit;
    QHBoxLayout *lay_stop_bit;
    QLabel *label_5;
    QComboBox *ui_stop_bit;
    QHBoxLayout *lay_ctrl_bit;
    QLabel *label_3;
    QComboBox *ui_ctrl_bit;
    QHBoxLayout *lay_button;
    QPushButton *ui_read_par;
    QPushButton *ui_setx_par;
    QPushButton *ui_exit_win;

    void setupUi(QWidget *uart_blck)
    {
        if (uart_blck->objectName().isEmpty())
            uart_blck->setObjectName(QString::fromUtf8("uart_blck"));
        uart_blck->resize(439, 554);
        verticalLayout_2 = new QVBoxLayout(uart_blck);
        verticalLayout_2->setObjectName(QString::fromUtf8("verticalLayout_2"));
        lay_show = new QVBoxLayout();
        lay_show->setObjectName(QString::fromUtf8("lay_show"));
        label_2 = new QLabel(uart_blck);
        label_2->setObjectName(QString::fromUtf8("label_2"));

        lay_show->addWidget(label_2);

        lay_port_bit = new QHBoxLayout();
        lay_port_bit->setObjectName(QString::fromUtf8("lay_port_bit"));
        label_7 = new QLabel(uart_blck);
        label_7->setObjectName(QString::fromUtf8("label_7"));

        lay_port_bit->addWidget(label_7);

        ui_port_bit = new QComboBox(uart_blck);
        ui_port_bit->setObjectName(QString::fromUtf8("ui_port_bit"));

        lay_port_bit->addWidget(ui_port_bit);

        lay_port_bit->setStretch(0, 1);
        lay_port_bit->setStretch(1, 3);

        lay_show->addLayout(lay_port_bit);

        lay_baud_bit = new QHBoxLayout();
        lay_baud_bit->setObjectName(QString::fromUtf8("lay_baud_bit"));
        label = new QLabel(uart_blck);
        label->setObjectName(QString::fromUtf8("label"));

        lay_baud_bit->addWidget(label);

        ui_baud_bit = new QComboBox(uart_blck);
        ui_baud_bit->setObjectName(QString::fromUtf8("ui_baud_bit"));

        lay_baud_bit->addWidget(ui_baud_bit);

        lay_baud_bit->setStretch(0, 1);
        lay_baud_bit->setStretch(1, 3);

        lay_show->addLayout(lay_baud_bit);

        lay_data_bit = new QHBoxLayout();
        lay_data_bit->setObjectName(QString::fromUtf8("lay_data_bit"));
        label_6 = new QLabel(uart_blck);
        label_6->setObjectName(QString::fromUtf8("label_6"));

        lay_data_bit->addWidget(label_6);

        ui_data_bit = new QComboBox(uart_blck);
        ui_data_bit->setObjectName(QString::fromUtf8("ui_data_bit"));

        lay_data_bit->addWidget(ui_data_bit);

        lay_data_bit->setStretch(0, 1);
        lay_data_bit->setStretch(1, 3);

        lay_show->addLayout(lay_data_bit);

        lay_chck_bit = new QHBoxLayout();
        lay_chck_bit->setObjectName(QString::fromUtf8("lay_chck_bit"));
        label_4 = new QLabel(uart_blck);
        label_4->setObjectName(QString::fromUtf8("label_4"));

        lay_chck_bit->addWidget(label_4);

        ui_chck_bit = new QComboBox(uart_blck);
        ui_chck_bit->setObjectName(QString::fromUtf8("ui_chck_bit"));

        lay_chck_bit->addWidget(ui_chck_bit);

        lay_chck_bit->setStretch(0, 1);
        lay_chck_bit->setStretch(1, 3);

        lay_show->addLayout(lay_chck_bit);

        lay_stop_bit = new QHBoxLayout();
        lay_stop_bit->setObjectName(QString::fromUtf8("lay_stop_bit"));
        label_5 = new QLabel(uart_blck);
        label_5->setObjectName(QString::fromUtf8("label_5"));

        lay_stop_bit->addWidget(label_5);

        ui_stop_bit = new QComboBox(uart_blck);
        ui_stop_bit->setObjectName(QString::fromUtf8("ui_stop_bit"));

        lay_stop_bit->addWidget(ui_stop_bit);

        lay_stop_bit->setStretch(0, 1);
        lay_stop_bit->setStretch(1, 3);

        lay_show->addLayout(lay_stop_bit);

        lay_ctrl_bit = new QHBoxLayout();
        lay_ctrl_bit->setObjectName(QString::fromUtf8("lay_ctrl_bit"));
        label_3 = new QLabel(uart_blck);
        label_3->setObjectName(QString::fromUtf8("label_3"));

        lay_ctrl_bit->addWidget(label_3);

        ui_ctrl_bit = new QComboBox(uart_blck);
        ui_ctrl_bit->setObjectName(QString::fromUtf8("ui_ctrl_bit"));

        lay_ctrl_bit->addWidget(ui_ctrl_bit);

        lay_ctrl_bit->setStretch(0, 1);
        lay_ctrl_bit->setStretch(1, 3);

        lay_show->addLayout(lay_ctrl_bit);

        lay_show->setStretch(0, 1);
        lay_show->setStretch(1, 1);
        lay_show->setStretch(2, 1);
        lay_show->setStretch(3, 1);
        lay_show->setStretch(4, 1);
        lay_show->setStretch(5, 1);
        lay_show->setStretch(6, 1);

        verticalLayout_2->addLayout(lay_show);

        lay_button = new QHBoxLayout();
        lay_button->setObjectName(QString::fromUtf8("lay_button"));
        ui_read_par = new QPushButton(uart_blck);
        ui_read_par->setObjectName(QString::fromUtf8("ui_read_par"));

        lay_button->addWidget(ui_read_par);

        ui_setx_par = new QPushButton(uart_blck);
        ui_setx_par->setObjectName(QString::fromUtf8("ui_setx_par"));

        lay_button->addWidget(ui_setx_par);

        ui_exit_win = new QPushButton(uart_blck);
        ui_exit_win->setObjectName(QString::fromUtf8("ui_exit_win"));

        lay_button->addWidget(ui_exit_win);


        verticalLayout_2->addLayout(lay_button);

        verticalLayout_2->setStretch(0, 6);
        verticalLayout_2->setStretch(1, 1);

        retranslateUi(uart_blck);

        QMetaObject::connectSlotsByName(uart_blck);
    } // setupUi

    void retranslateUi(QWidget *uart_blck)
    {
        uart_blck->setWindowTitle(QApplication::translate("uart_blck", "Form", nullptr));
        label_2->setText(QApplication::translate("uart_blck", "<html><head/><body><p align=\"center\"><span style=\" font-size:22pt;\">\344\270\262\345\217\243\351\205\215\347\275\256</span></p></body></html>", nullptr));
        label_7->setText(QApplication::translate("uart_blck", "\347\253\257\345\217\243\345\217\267", nullptr));
        label->setText(QApplication::translate("uart_blck", "\346\263\242\347\211\271\347\216\207", nullptr));
        label_6->setText(QApplication::translate("uart_blck", "\346\225\260\346\215\256\344\275\215", nullptr));
        label_4->setText(QApplication::translate("uart_blck", "\346\240\241\351\252\214\344\275\215", nullptr));
        label_5->setText(QApplication::translate("uart_blck", "\345\201\234\346\255\242\344\275\215", nullptr));
        label_3->setText(QApplication::translate("uart_blck", "\346\216\247\345\210\266\346\265\201", nullptr));
        ui_read_par->setText(QApplication::translate("uart_blck", "\350\257\273\345\217\226", nullptr));
        ui_setx_par->setText(QApplication::translate("uart_blck", "\351\205\215\347\275\256", nullptr));
        ui_exit_win->setText(QApplication::translate("uart_blck", "\351\200\200\345\207\272", nullptr));
    } // retranslateUi

};

namespace Ui {
    class uart_blck: public Ui_uart_blck {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_UART_BLCK_H
