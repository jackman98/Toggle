#ifndef MOUSE_H
#define MOUSE_H

#include <QObject>
#include <QCursor>

class Mouse : public QObject
{
	Q_OBJECT
	Q_PROPERTY(int x READ x)
	Q_PROPERTY(int y READ y)
public:
	explicit Mouse(QObject *parent = nullptr);
	int x() const;
	int y() const;

private:
	QCursor m_cursor;
	int m_x;
	int m_y;
};

#endif // MOUSE_H
