import logging

import sqlalchemy as db
from sqlalchemy.exc import SQLAlchemyError
from sqlalchemy.orm import Session
from backend.repository.abstract_repository import AbstractRepository


class DatabaseRepository(AbstractRepository):
    def __init__(self, connection_string, entity_type):
        self.engine = db.create_engine(connection_string)
        self.entity_type = entity_type

    def add(self, entity):
        logging.info("Inserting {} to database".format(self.entity_type.__name__))
        session = Session(bind=self.engine)
        try:
            session.add(entity)
            session.commit()
            logging.info("Record inserted with success")
        except SQLAlchemyError as e:
            logging.error(e)
            session.rollback()
        finally:
            session.close()

    def get(self, id_):
        logging.info("Returning {} with id {} from database".format(self.entity_type.__name__, id_))
        session = Session(bind=self.engine)
        try:
            return session.query(self.entity_type).get(id_)
        except SQLAlchemyError as e:
            logging.error(e)
        finally:
            session.close()

    def get_all(self):
        logging.info("Returning all {}s from database".format(self.entity_type.__name__))
        session = Session(bind=self.engine)
        try:
            return session.query(self.entity_type).all()
        except SQLAlchemyError as e:
            logging.error(e)
        finally:
            session.close()

    def update(self, id_, entity):
        logging.info("Updating {} with id {}".format(self.entity_type.__name__, id_))
        session = Session(bind=self.engine)
        try:
            old_entity = session.query(self.entity_type).get(id_)
            old_entity.update(entity)
            session.commit()
            logging.info("Record updated with success")
        except SQLAlchemyError as e:
            logging.error(e)
        finally:
            session.close()

    def delete(self, id_):
        logging.info("Deleting {} with id {}".format(self.entity_type.__name__, id_))
        session = Session(bind=self.engine)
        try:
            entity = session.query(self.entity_type).get(id_)
            session.delete(entity)
            session.commit()
            logging.info("Record deleted with success")
        except SQLAlchemyError as e:
            logging.error(e)
        finally:
            session.close()
