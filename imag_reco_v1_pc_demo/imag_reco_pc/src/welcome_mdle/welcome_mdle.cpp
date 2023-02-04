#include "welcome_mdle.h"
#include "ui_welcome_mdle.h"
// --------------------------------------------
// user file
#include <QApplication>
#include <QDebug>
#include "../MACRO.h"
welcome_mdle::welcome_mdle(QWidget *parent) :
    QWidget(parent),
    ui(new Ui::welcome_mdle)
{
    ui->setupUi(this);
    // --------------------------------------------
    // video

    play_driv = new QMediaPlayer  (this) ;
    play_show = new QVideoWidget  (this) ;
    play_list = new QMediaPlaylist(this);
#ifndef DEBUG_MODE
    // play prepare
    play_show->setWindowFlag(Qt::FramelessWindowHint);
    ui->ui_show->addWidget(play_show);
    play_driv->setVideoOutput(play_show);
    play_driv->setPlaylist(play_list);
    // set video path
    QString p_video = QApplication::applicationDirPath() + "/video/zynq.mp4";
    //play_driv->setMedia(QUrl::fromLocalFile(p_video));
    play_list->addMedia(QUrl::fromLocalFile(p_video));
    play_list->setPlaybackMode(QMediaPlaylist::CurrentItemInLoop);
    play_driv->setPlaylist(play_list);

    //play_driv->setMedia(QUrl::fromLocalFile("D:\\f1_library2\\i0_imag_reco\\imag_reco_pc_demo\\imag_reco_pc\\video\\zynq.mp4"));
    //play_driv->setMedia(QUrl::fromLocalFile("D:\\f1_library2\\i0_imag_reco\\imag_reco_pc_demo\\imag_reco_pc\\video\\rain.mp3"));
    play_driv->play();
#endif

}

welcome_mdle::~welcome_mdle()
{
    delete play_driv ;
    delete play_show ;
    delete play_list ;
    delete ui;
}
