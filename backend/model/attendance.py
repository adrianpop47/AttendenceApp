from sqlalchemy import Column, Integer, String
from sqlalchemy.orm import declarative_base

Base = declarative_base()


class Attendance(Base):
    __tablename__ = "attendance"

    id = Column(Integer, primary_key=True)
    userId = Column(Integer)
    date = Column(String)
    time = Column(String)
    type = Column(String)

    def update(self, other):
        self.userId = other.userId
        self.date = other.date
        self.time = other.time
        self.type = other.type

    def __str__(self):
        return '{}, {}, {}, {}, {}'.format(self.id, self.userId, self.date, self.time, self.type)
