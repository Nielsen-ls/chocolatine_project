# Chocolatine Project

This project uses a GitHub Actions workflow to automate various stages of the development process, ensuring code quality, successful compilation, and proper testing. Below is an overview of the workflow defined in `.github/workflows/chocolatine.yml`.

## Workflow Overview

### 1. **Triggering Events**
The workflow is triggered on:
- **Push events**: Excluding branches matching the pattern `ga-ignore-*`.
- **Pull request events**: Excluding branches matching the pattern `ga-ignore-*`.

### 2. **Environment Variables**
- `EXECUTABLES`: Specifies the expected executables (default: `a.out`).

### 3. **Jobs**

#### **Check Coding Style**
- **Runs on**: `ubuntu-latest` with a container `ghcr.io/epitech/coding-style-checker:latest`.
- **Steps**:
  1. Checkout the repository.
  2. Run the coding style checker using `check.sh`.
  3. Display errors if the coding style check fails.

#### **Check Program Compilation**
- **Runs on**: `ubuntu-latest` with a container `epitechcontent/epitest-docker`.
- **Depends on**: `check_coding_style`.
- **Steps**:
  1. Checkout the repository.
  2. Compile the project with a timeout of 120 seconds.
  3. Clean the project using `make clean`.
  4. Verify that the expected executables are present and executable.

#### **Run Tests**
- **Runs on**: `ubuntu-latest` with a container `epitechcontent/epitest-docker`.
- **Depends on**: `check_program_compilation`.
- **Steps**:
  1. Checkout the repository.
  2. Run the project's tests with a timeout of 120 seconds.

#### **Push to Mirror**
- **Runs on**: `ubuntu-latest`.
- **Depends on**: `run_tests`.
- **Condition**: Only runs on `push` events.
- **Steps**:
  1. Checkout the repository.
  2. Mirror the repository to a target URL using the `pixta-dev/repository-mirroring-action`.
  3. Push the repository to GitHub using the same action.

## Secrets Required
- `MIRROR_URL`: The URL of the target repository for mirroring.
- `GIT_SSH_PRIVATE_KEY`: The SSH private key for authentication.

## Notes
- The workflow ensures that only code adhering to the coding style, compiling successfully, and passing tests is mirrored or pushed.
- The use of containers ensures consistency in the development environment.

