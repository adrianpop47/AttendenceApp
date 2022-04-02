class AbstractRepository:

    def add(self, entity):
        raise NotImplementedError

    def get(self, id_):
        raise NotImplementedError

    def get_all(self):
        raise NotImplementedError

    def update(self, id_, entity):
        raise NotImplementedError

    def delete(self, id_):
        raise NotImplementedError
