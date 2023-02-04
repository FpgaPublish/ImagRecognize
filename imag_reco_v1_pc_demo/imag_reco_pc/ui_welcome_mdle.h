/********************************************************************************
** Form generated from reading UI file 'welcome_mdle.ui'
**
** Created by: Qt User Interface Compiler version 5.12.11
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef UI_WELCOME_MDLE_H
#define UI_WELCOME_MDLE_H

#include <QtCore/QVariant>
#include <QtWidgets/QApplication>
#include <QtWidgets/QHBoxLayout>
#include <QtWidgets/QPushButton>
#include <QtWidgets/QVBoxLayout>
#include <QtWidgets/QWidget>

QT_BEGIN_NAMESPACE

class Ui_welcome_mdle
{
public:
    QHBoxLayout *horizontalLayout;
    QPushButton *ui_start;
    QVBoxLayout *ui_show;
    QPushButton *ui_help;

    void setupUi(QWidget *welcome_mdle)
    {
        if (welcome_mdle->objectName().isEmpty())
            welcome_mdle->setObjectName(QString::fromUtf8("welcome_mdle"));
        welcome_mdle->resize(860, 564);
        horizontalLayout = new QHBoxLayout(welcome_mdle);
        horizontalLayout->setObjectName(QString::fromUtf8("horizontalLayout"));
        ui_start = new QPushButton(welcome_mdle);
        ui_start->setObjectName(QString::fromUtf8("ui_start"));

        horizontalLayout->addWidget(ui_start);

        ui_show = new QVBoxLayout();
        ui_show->setObjectName(QString::fromUtf8("ui_show"));

        horizontalLayout->addLayout(ui_show);

        ui_help = new QPushButton(welcome_mdle);
        ui_help->setObjectName(QString::fromUtf8("ui_help"));

        horizontalLayout->addWidget(ui_help);

        horizontalLayout->setStretch(0, 1);
        horizontalLayout->setStretch(1, 11);
        horizontalLayout->setStretch(2, 1);

        retranslateUi(welcome_mdle);

        QMetaObject::connectSlotsByName(welcome_mdle);
    } // setupUi

    void retranslateUi(QWidget *welcome_mdle)
    {
        welcome_mdle->setWindowTitle(QApplication::translate("welcome_mdle", "Form", nullptr));
        ui_start->setText(QApplication::translate("welcome_mdle", "\346\225\231\347\250\213", nullptr));
        ui_help->setText(QApplication::translate("welcome_mdle", "\345\270\256\345\212\251", nullptr));
    } // retranslateUi

};

namespace Ui {
    class welcome_mdle: public Ui_welcome_mdle {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_WELCOME_MDLE_H
