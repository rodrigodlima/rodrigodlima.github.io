# Security & Code Quality Setup

This project uses GitHub Actions for automated security scanning and code quality analysis.

## 🔒 Security Tools

### Trivy
- **Purpose:** Vulnerability scanning for dependencies and misconfigurations
- **Configuration:** Automatically configured in `.github/workflows/deploy.yml`
- **Results:** Available in GitHub Security tab under "Code scanning alerts"
- **No setup required** - runs automatically on every push

### SonarCloud
- **Purpose:** Code quality, code smells, bugs, and security hotspots analysis
- **Setup Required:** Yes

#### SonarCloud Setup Steps

1. **Create SonarCloud Account**
   - Go to https://sonarcloud.io
   - Sign in with your GitHub account
   - Create a new organization or use existing

2. **Import Repository**
   - Click "+" → "Analyze new project"
   - Select `rodrigodlima/rodrigodlima.github.io`
   - Follow the setup wizard

3. **Configure GitHub Secret**
   - In SonarCloud, go to your project → Administration → Security
   - Generate a token
   - In GitHub, go to Settings → Secrets and variables → Actions
   - Create a new secret named `SONAR_TOKEN` with your SonarCloud token

4. **Update sonar-project.properties**
   - Update `sonar.organization` with your SonarCloud organization key
   - Update `sonar.projectKey` if needed (format: `organization_repository`)

## 📊 Monitoring

### GitHub Security Tab
- View Trivy vulnerability scan results
- Track security advisories
- Monitor Dependabot alerts

### SonarCloud Dashboard
- Code quality metrics
- Technical debt
- Security hotspots
- Code coverage (if configured)

## 🚀 CI/CD Pipeline

The workflow runs in this order:

1. **Security Scan** (Trivy)
   - Scans for vulnerabilities in dependencies
   - Uploads results to GitHub Security tab
   - Fails if critical vulnerabilities found

2. **Code Quality** (SonarCloud)
   - Analyzes code quality
   - Checks for bugs and code smells
   - Continues even if quality gate fails

3. **Build & Deploy**
   - Only runs if security and quality checks pass
   - Generates static site with Jekyll/Octopress
   - Deploys to `main` branch
   - GitHub Pages serves from `main` branch

## 🔧 Local Development

To run security checks locally:

```bash
# Install Trivy
brew install aquasecurity/trivy/trivy

# Run Trivy scan
trivy fs .

# Run Trivy with severity filter
trivy fs --severity CRITICAL,HIGH .
```

## 📝 Configuration Files

- `.github/workflows/deploy.yml` - Main CI/CD pipeline
- `sonar-project.properties` - SonarCloud configuration
- `Gemfile.lock` - Ruby dependencies (scanned by Trivy)

## 🛡️ Security Best Practices

1. Keep dependencies up to date
2. Review Trivy scan results regularly
3. Address SonarCloud security hotspots
4. Enable Dependabot for automated dependency updates
5. Review and approve pull requests before merging

## 📚 Resources

- [Trivy Documentation](https://aquasecurity.github.io/trivy/)
- [SonarCloud Documentation](https://docs.sonarcloud.io/)
- [GitHub Security Features](https://docs.github.com/en/code-security)
