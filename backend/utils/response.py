class Response:

    def __init__(self, responseType, data=None):
        self.type = responseType
        self.data = data

    def __str__(self):
        return "{}: {}".format(self.type, self.data)


class SignUpOkResponse(Response):
    def __init__(self):
        super().__init__("SIGN_UP_OK")


class SignUpFailedResponse(Response):
    def __init__(self):
        super().__init__("SIGN_UP_FAILED")


class DuplicateSignUpEmailResponse(Response):
    def __init__(self):
        super().__init__("DUPLICATE_SIGN_UP_EMAIL")


class SignInOkResponse(Response):
    def __init__(self, data):
        super().__init__("SIGN_IN_OK", data)


class SignInFailedResponse(Response):
    def __init__(self):
        super().__init__("SIGN_IN_FAILED")


class FoundPersonResponse(Response):
    def __init__(self, data):
        super().__init__("FOUND_PERSON", data)


class UnknownPersonResponse(Response):
    def __init__(self):
        super().__init__("UNKNOWN_PERSON")


class NoFaceDetectedResponse(Response):
    def __init__(self):
        super().__init__("NO_FACE_DETECTED")
