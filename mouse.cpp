#include "mouse.h"

Mouse::Mouse(QObject *parent) : QObject(parent)
{

}

int Mouse::x() const
{
	return m_cursor.pos().x();
}

int Mouse::y() const
{
	return m_cursor.pos().y();
}
