sealed class LoginIntent {}

class InitializeLoginFormIntent extends LoginIntent {}

class ToggleObscurePasswordIntent extends LoginIntent {}

class ToggleRememberMeIntent extends LoginIntent {}

class LoginWithEmailAndPasswordIntent extends LoginIntent {}

class LoginAsGuestIntent extends LoginIntent {}
