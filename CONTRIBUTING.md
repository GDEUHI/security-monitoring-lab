# Contributing to ASTL

## Welcome!

Thank you for considering contributing to the Automated Security Testing Lab (ASTL)! This document provides guidelines and instructions for contributing.

## Code of Conduct

### Our Pledge

We pledge to make participation in our project a harassment-free experience for everyone, regardless of age, body size, disability, ethnicity, gender identity and expression, level of experience, nationality, personal appearance, race, religion, or sexual identity and orientation.

### Our Standards

Examples of behavior that contributes to creating a positive environment include:
- Using welcoming and inclusive language
- Being respectful of differing viewpoints and experiences
- Gracefully accepting constructive criticism
- Focusing on what is best for the community
- Showing empathy towards other community members

## How to Contribute

### Reporting Bugs

1. **Check Existing Issues**
   - Search the [issue tracker](https://github.com/yourusername/ethical-hacking-lab/issues)
   - Check if the bug has already been reported

2. **Create a Bug Report**
   - Use the bug report template
   - Include detailed steps to reproduce
   - Provide system information
   - Add relevant logs

Example bug report:
```markdown
**Description**
A clear description of the bug

**Steps to Reproduce**
1. Go to '...'
2. Click on '....'
3. See error

**Expected Behavior**
What you expected to happen

**Actual Behavior**
What actually happened

**Screenshots**
If applicable

**System Information**
- OS: [e.g., macOS 12.0]
- Docker version: [e.g., 20.10.8]
- ASTL version: [e.g., 1.0.0]
```

### Suggesting Enhancements

1. **Check Existing Suggestions**
   - Review open feature requests
   - Ensure it hasn't been rejected before

2. **Create a Feature Request**
   - Use the feature request template
   - Provide clear use cases
   - Explain the benefits

Example feature request:
```markdown
**Feature Description**
A clear description of the feature

**Use Cases**
1. When would this be useful?
2. Who would use this?

**Proposed Solution**
How do you think this should be implemented?

**Alternatives Considered**
What other approaches have you considered?
```

### Pull Requests

1. **Fork the Repository**
```bash
git clone https://github.com/yourusername/ethical-hacking-lab.git
cd ethical-hacking-lab
git checkout -b feature/your-feature
```

2. **Make Your Changes**
   - Follow the coding standards
   - Add tests if applicable
   - Update documentation

3. **Commit Your Changes**
```bash
git add .
git commit -m "feat: add new security workflow"
```

4. **Push to Your Fork**
```bash
git push origin feature/your-feature
```

5. **Create Pull Request**
   - Use the pull request template
   - Link related issues
   - Provide clear description

Example PR description:
```markdown
**Related Issue**
Fixes #123

**Description**
Brief description of the changes

**Testing**
How have you tested these changes?

**Screenshots**
If applicable

**Checklist**
- [ ] Tests added/updated
- [ ] Documentation updated
- [ ] Coding standards followed
```

## Development Guidelines

### Code Style

#### Python
```python
# Use descriptive names
def analyze_security_events(events: List[Event]) -> SecurityReport:
    """
    Analyze security events and generate a report.
    
    Args:
        events: List of security events
        
    Returns:
        SecurityReport object
    """
    pass
```

#### JavaScript
```javascript
// Use const/let, avoid var
const analyzeEvents = (events) => {
  // Implementation
};

// Use async/await
async function processSecurityAlert(alert) {
  try {
    await sendNotification(alert);
  } catch (error) {
    logger.error('Failed to process alert', error);
  }
}
```

### Testing

#### Writing Tests
```python
def test_security_workflow():
    # Arrange
    workflow = SecurityWorkflow()
    
    # Act
    result = workflow.execute()
    
    # Assert
    assert result.status == 'success'
    assert len(result.findings) > 0
```

#### Running Tests
```bash
# Run all tests
pytest

# Run specific test file
pytest tests/test_security_workflow.py

# Run with coverage
pytest --cov=.
```

### Documentation

#### Code Documentation
```python
class SecurityScanner:
    """
    Security scanner for network devices.
    
    Attributes:
        target_range (str): Network range to scan
        scan_type (str): Type of scan to perform
    """
    
    def scan(self) -> ScanResult:
        """
        Perform security scan.
        
        Returns:
            ScanResult: Results of the security scan
            
        Raises:
            ScanError: If scan fails
        """
        pass
```

#### API Documentation
```yaml
paths:
  /api/v1/scans:
    post:
      summary: Start a security scan
      parameters:
        - name: target
          in: body
          required: true
          schema:
            type: string
```

## Release Process

### Version Numbers
We use [Semantic Versioning](https://semver.org/):
- MAJOR version for incompatible API changes
- MINOR version for new functionality
- PATCH version for bug fixes

### Creating a Release
1. Update version numbers
2. Update CHANGELOG.md
3. Create release branch
4. Run tests
5. Create GitHub release
6. Deploy

Example CHANGELOG entry:
```markdown
## [1.1.0] - 2025-02-20

### Added
- New security workflow for threat hunting
- API endpoint for custom scan configurations

### Changed
- Improved performance of vulnerability scanner
- Updated documentation for workflow creation

### Fixed
- Issue with alert notifications
- Memory leak in long-running scans
```

## Community

### Communication Channels
- GitHub Discussions
- Discord Server
- Monthly Community Calls

### Recognition
Contributors will be:
- Listed in CONTRIBUTORS.md
- Mentioned in release notes
- Invited to community events

## Questions?

Feel free to:
- Open an issue
- Start a discussion
- Join our Discord
- Email the maintainers

Thank you for contributing to ASTL!
