from sqlalchemy import Column, Integer, String
from sqlalchemy.orm import declarative_base

Base = declarative_base()


class User(Base):
    __tablename__ = "user"

    id = Column(Integer, primary_key=True)
    name = Column(String)
    email = Column(String)
    password = Column(String)
    role = Column(String)

    def update(self, other):
        self.name = other.name
        self.email = other.email
        self.password = other.password
        self.role = other.role


    def __str__(self):
        return '{}. {}, {}, {}, {}'.format(self.id, self.name, self.email, self.password, self.role)
