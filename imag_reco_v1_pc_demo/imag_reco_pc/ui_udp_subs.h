/********************************************************************************
** Form generated from reading UI file 'udp_subs.ui'
**
** Created by: Qt User Interface Compiler version 5.12.11
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef UI_UDP_SUBS_H
#define UI_UDP_SUBS_H

#include <QtCore/QVariant>
#include <QtWidgets/QApplication>
#include <QtWidgets/QDialog>
#include <QtWidgets/QDialogButtonBox>
#include <QtWidgets/QHBoxLayout>
#include <QtWidgets/QLabel>
#include <QtWidgets/QLineEdit>
#include <QtWidgets/QVBoxLayout>

QT_BEGIN_NAMESPACE

class Ui_udp_subs
{
public:
    QVBoxLayout *verticalLayout;
    QVBoxLayout *udp_subs_param;
    QHBoxLayout *master_ipv4;
    QLabel *ui_master_ipv4;
    QLineEdit *ui_master_ipv4_in;
    QHBoxLayout *master_port;
    QLabel *ui_master_port;
    QLineEdit *ui_master_port_in;
    QHBoxLayout *slaver_ipv4;
    QLabel *ui_slaver_ipv4;
    QLineEdit *ui_slaver_ipv4_in;
    QHBoxLayout *slaver_port;
    QLabel *ui_slaver_port;
    QLineEdit *ui_slaver_port_in;
    QDialogButtonBox *buttonBox;

    void setupUi(QDialog *udp_subs)
    {
        if (udp_subs->objectName().isEmpty())
            udp_subs->setObjectName(QString::fromUtf8("udp_subs"));
        udp_subs->resize(646, 457);
        verticalLayout = new QVBoxLayout(udp_subs);
        verticalLayout->setObjectName(QString::fromUtf8("verticalLayout"));
        udp_subs_param = new QVBoxLayout();
        udp_subs_param->setObjectName(QString::fromUtf8("udp_subs_param"));
        master_ipv4 = new QHBoxLayout();
        master_ipv4->setObjectName(QString::fromUtf8("master_ipv4"));
        ui_master_ipv4 = new QLabel(udp_subs);
        ui_master_ipv4->setObjectName(QString::fromUtf8("ui_master_ipv4"));

        master_ipv4->addWidget(ui_master_ipv4);

        ui_master_ipv4_in = new QLineEdit(udp_subs);
        ui_master_ipv4_in->setObjectName(QString::fromUtf8("ui_master_ipv4_in"));

        master_ipv4->addWidget(ui_master_ipv4_in);

        master_ipv4->setStretch(0, 1);
        master_ipv4->setStretch(1, 1);

        udp_subs_param->addLayout(master_ipv4);

        master_port = new QHBoxLayout();
        master_port->setObjectName(QString::fromUtf8("master_port"));
        ui_master_port = new QLabel(udp_subs);
        ui_master_port->setObjectName(QString::fromUtf8("ui_master_port"));

        master_port->addWidget(ui_master_port);

        ui_master_port_in = new QLineEdit(udp_subs);
        ui_master_port_in->setObjectName(QString::fromUtf8("ui_master_port_in"));

        master_port->addWidget(ui_master_port_in);

        master_port->setStretch(0, 1);
        master_port->setStretch(1, 1);

        udp_subs_param->addLayout(master_port);

        slaver_ipv4 = new QHBoxLayout();
        slaver_ipv4->setObjectName(QString::fromUtf8("slaver_ipv4"));
        ui_slaver_ipv4 = new QLabel(udp_subs);
        ui_slaver_ipv4->setObjectName(QString::fromUtf8("ui_slaver_ipv4"));

        slaver_ipv4->addWidget(ui_slaver_ipv4);

        ui_slaver_ipv4_in = new QLineEdit(udp_subs);
        ui_slaver_ipv4_in->setObjectName(QString::fromUtf8("ui_slaver_ipv4_in"));

        slaver_ipv4->addWidget(ui_slaver_ipv4_in);

        slaver_ipv4->setStretch(0, 1);
        slaver_ipv4->setStretch(1, 1);

        udp_subs_param->addLayout(slaver_ipv4);

        slaver_port = new QHBoxLayout();
        slaver_port->setObjectName(QString::fromUtf8("slaver_port"));
        ui_slaver_port = new QLabel(udp_subs);
        ui_slaver_port->setObjectName(QString::fromUtf8("ui_slaver_port"));

        slaver_port->addWidget(ui_slaver_port);

        ui_slaver_port_in = new QLineEdit(udp_subs);
        ui_slaver_port_in->setObjectName(QString::fromUtf8("ui_slaver_port_in"));

        slaver_port->addWidget(ui_slaver_port_in);

        slaver_port->setStretch(0, 1);
        slaver_port->setStretch(1, 1);

        udp_subs_param->addLayout(slaver_port);


        verticalLayout->addLayout(udp_subs_param);

        buttonBox = new QDialogButtonBox(udp_subs);
        buttonBox->setObjectName(QString::fromUtf8("buttonBox"));
        buttonBox->setOrientation(Qt::Horizontal);
        buttonBox->setStandardButtons(QDialogButtonBox::Cancel|QDialogButtonBox::Ok);

        verticalLayout->addWidget(buttonBox);


        retranslateUi(udp_subs);
        QObject::connect(buttonBox, SIGNAL(accepted()), udp_subs, SLOT(accept()));
        QObject::connect(buttonBox, SIGNAL(rejected()), udp_subs, SLOT(reject()));

        QMetaObject::connectSlotsByName(udp_subs);
    } // setupUi

    void retranslateUi(QDialog *udp_subs)
    {
        udp_subs->setWindowTitle(QApplication::translate("udp_subs", "Dialog", nullptr));
        ui_master_ipv4->setText(QApplication::translate("udp_subs", "\344\270\273\346\234\272IPV4\345\234\260\345\235\200\357\274\232", nullptr));
        ui_master_port->setText(QApplication::translate("udp_subs", "\344\270\273\346\234\272PORT\347\253\257\345\217\243\357\274\232", nullptr));
        ui_slaver_ipv4->setText(QApplication::translate("udp_subs", "\350\256\276\345\244\207IPV4\345\234\260\345\235\200\357\274\232", nullptr));
        ui_slaver_port->setText(QApplication::translate("udp_subs", "\350\256\276\345\244\207PORT\347\253\257\345\217\243\357\274\232", nullptr));
    } // retranslateUi

};

namespace Ui {
    class udp_subs: public Ui_udp_subs {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_UDP_SUBS_H
