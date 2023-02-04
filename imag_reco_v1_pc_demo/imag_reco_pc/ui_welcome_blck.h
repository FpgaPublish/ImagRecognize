/********************************************************************************
** Form generated from reading UI file 'welcome_blck.ui'
**
** Created by: Qt User Interface Compiler version 5.12.11
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef UI_WELCOME_BLCK_H
#define UI_WELCOME_BLCK_H

#include <QtCore/QVariant>
#include <QtWidgets/QApplication>
#include <QtWidgets/QDialog>
#include <QtWidgets/QPushButton>
#include <QtWidgets/QVBoxLayout>

QT_BEGIN_NAMESPACE

class Ui_welcome_blck
{
public:
    QVBoxLayout *verticalLayout;
    QVBoxLayout *ui_show;
    QPushButton *ui_play;

    void setupUi(QDialog *welcome_blck)
    {
        if (welcome_blck->objectName().isEmpty())
            welcome_blck->setObjectName(QString::fromUtf8("welcome_blck"));
        welcome_blck->resize(724, 564);
        verticalLayout = new QVBoxLayout(welcome_blck);
        verticalLayout->setObjectName(QString::fromUtf8("verticalLayout"));
        ui_show = new QVBoxLayout();
        ui_show->setObjectName(QString::fromUtf8("ui_show"));

        verticalLayout->addLayout(ui_show);

        ui_play = new QPushButton(welcome_blck);
        ui_play->setObjectName(QString::fromUtf8("ui_play"));

        verticalLayout->addWidget(ui_play);


        retranslateUi(welcome_blck);

        QMetaObject::connectSlotsByName(welcome_blck);
    } // setupUi

    void retranslateUi(QDialog *welcome_blck)
    {
        welcome_blck->setWindowTitle(QApplication::translate("welcome_blck", "Dialog", nullptr));
        ui_play->setText(QApplication::translate("welcome_blck", "\346\222\255\346\224\276", nullptr));
    } // retranslateUi

};

namespace Ui {
    class welcome_blck: public Ui_welcome_blck {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_WELCOME_BLCK_H
