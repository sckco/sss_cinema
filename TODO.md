# TODO List for SSS Cinema App Modifications

## Completed Tasks
- [x] Center the login and register forms on the page
- [x] Add "SSS Cinema" app name above the login and register forms
- [x] Add visual validation with red borders for TextFields on errors (invalid email, weak password, login failed)
- [x] Integrate validation functions from `lib/utils/validators.dart`
- [x] Use error messages from `lib/utils/constants.dart`
- [x] Update register screen with centered layout, app name, and validation

## Pending Tasks
- [ ] Test the login and register screens for proper functionality
- [ ] Ensure the app builds without errors
- [ ] Verify the UI changes on different screen sizes
- [ ] Update any related documentation if necessary

## Notes
- The login screen now centers the form, displays "SSS Cinema" at the top, and shows red borders for validation errors.
- The register screen has similar changes with additional validation for the name field.
- Validation includes email format check, password length (minimum 6 characters), and login failure handling.
