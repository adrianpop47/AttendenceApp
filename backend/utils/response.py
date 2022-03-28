class Response:

    def __init__(self, responseType, data=None):
        self.type = responseType
        self.data = data

    def __str__(self):
        return "{}: {}".format(self.type, self.data)


class FoundPersonResponse(Response):

    def __init__(self, data):
        super().__init__("FOUND_PERSON", data)


class UnknownPersonResponse(Response):

    def __init__(self):
        super().__init__("UNKNOWN_PERSON")


class NoFaceDetectedResponse(Response):

    def __init__(self):
        super().__init__("NO_FACE_DETECTED")
