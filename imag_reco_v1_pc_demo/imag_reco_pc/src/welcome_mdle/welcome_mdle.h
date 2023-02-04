#ifndef WELCOME_MDLE_H
#define WELCOME_MDLE_H

#include <QWidget>
// --------------------------------------------
// user file
#include <QMediaPlayer>
#include <QVideoWidget>
#include <QMediaPlaylist>
namespace Ui {
class welcome_mdle;
}

class welcome_mdle : public QWidget
{
    Q_OBJECT

public:
    explicit welcome_mdle(QWidget *parent = nullptr);
    ~welcome_mdle();

private:
    Ui::welcome_mdle *ui;
    // --------------------------------------------
    //  video
    QMediaPlayer   *play_driv;
    QVideoWidget   *play_show;
    QMediaPlaylist *play_list;
};

#endif // WELCOME_MDLE_H
