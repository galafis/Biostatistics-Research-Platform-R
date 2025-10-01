# Contributing to Biostatistics-Research-Platform-R

We welcome contributions to this project! Please follow these guidelines to ensure a smooth and collaborative process.

## How to Contribute

1.  **Fork the repository:** Start by forking the `Biostatistics-Research-Platform-R` repository to your GitHub account.
2.  **Clone your forked repository:**
    ```bash
    git clone https://github.com/YOUR_USERNAME/Biostatistics-Research-Platform-R.git
    cd Biostatistics-Research-Platform-R
    ```
3.  **Create a new branch:** For each new feature or bug fix, create a new branch:
    ```bash
    git checkout -b feature/your-feature-name
    # or
    git checkout -b bugfix/your-bug-fix-name
    ```
4.  **Make your changes:** Implement your feature or fix your bug. Ensure your code adheres to the project's coding style and best practices.
5.  **Write tests:** If you're adding new functionality, please write corresponding tests. For bug fixes, a test that reproduces the bug before the fix and passes after the fix is ideal.
6.  **Run tests:** Before submitting, make sure all existing tests pass and your new tests pass.
    ```bash
    Rscript tests/test_main.R
    ```
7.  **Commit your changes:** Write clear and concise commit messages.
    ```bash
    git commit -m "feat: Add new feature for X"
    # or
    git commit -m "fix: Resolve bug in Y"
    ```
8.  **Push to your fork:**
    ```bash
    git push origin feature/your-feature-name
    ```
9.  **Create a Pull Request (PR):** Go to the original `Biostatistics-Research-Platform-R` repository on GitHub and open a new Pull Request from your forked repository. Provide a detailed description of your changes.

## Code Style

*   Follow standard R coding conventions.
*   Use meaningful variable and function names.
*   Add comments where necessary to explain complex logic.
*   Ensure consistent indentation and formatting.

## Reporting Bugs

If you find a bug, please open an issue on the GitHub repository. Include:

*   A clear and concise description of the bug.
*   Steps to reproduce the behavior.
*   Expected behavior.
*   Screenshots or error messages, if applicable.
*   Your R version and package versions.

## Feature Requests

We welcome ideas for new features! Please open an issue to discuss your ideas. Provide:

*   A clear and concise description of the feature.
*   Why this feature would be useful.
*   Any potential implementation details or considerations.

Thank you for contributing to the Biostatistics-Research-Platform-R project!
