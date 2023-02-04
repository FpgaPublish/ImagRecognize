#include "mainwindow.h"

#include <QApplication>
#include "./src/MACRO.h"
#include <QStyleFactory>
int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    MainWindow w;
    w.show();
    //set dark
    qApp->setStyle(QStyleFactory::create("Fusion"));
    QPalette palette;
    palette.setColor(QPalette::Window, QColor(53, 53, 53));
    palette.setColor(QPalette::WindowText, Qt::white);
    palette.setColor(QPalette::Base, QColor(15, 15, 15));
    palette.setColor(QPalette::AlternateBase, QColor(53, 53, 53));
    palette.setColor(QPalette::ToolTipBase, Qt::white);
    palette.setColor(QPalette::ToolTipText, Qt::white);
    palette.setColor(QPalette::Text, Qt::white);
    palette.setColor(QPalette::Button, QColor(53, 53, 53));
    palette.setColor(QPalette::ButtonText, Qt::white);
    palette.setColor(QPalette::BrightText, Qt::red);
    //palette.setColor(QPalette::Highlight, QColor(142, 45, 197).lighter()); //紫色
    palette.setColor(QPalette::Highlight, QColor(161, 65, 13).lighter());//橙色
    palette.setColor(QPalette::HighlightedText, Qt::black);
    qApp->setPalette(palette);
    //add macro
    qRegisterMetaType<SUdpPck>("SUdpPck");

    //set ICON
    QString p_icon_app = QApplication::applicationDirPath() + "/icons/reco_eye.ico";
    a.setWindowIcon(QIcon(p_icon_app));
    return a.exec();
}
