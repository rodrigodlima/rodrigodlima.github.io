# Security Policy

## 🔒 Security Features

This repository implements multiple layers of security scanning:

### 1. Automated Security Scanning (CI/CD)

Every push to the `source` branch triggers:

- **Trivy Vulnerability Scanning**: Scans all dependencies (Ruby gems) for known CVEs
- **Trivy Secret Scanning**: Detects exposed secrets, API keys, tokens, and credentials
- **GitHub Security Tab**: All findings are automatically uploaded and tracked

### 2. Local Security Checks

Before committing, run the security check script:

```bash
./check_security.sh
```

This will:
- ✅ Scan for secrets in your code
- ✅ Check for vulnerable dependencies
- ✅ Detect sensitive files
- ✅ Verify .gitignore coverage

### 3. Protected Patterns

The following sensitive file patterns are automatically ignored:

- Private keys: `*.pem`, `*.key`, `*id_rsa*`, etc.
- Certificates: `*.p12`, `*.pfx`, `*.asc`
- Environment files: `.env`, `.env.*`
- Credentials: `*credentials*`, `*secret*`, `*password*`
- AWS config: `.aws/`
- VPN configs: `*.ovpn`

## 🚨 What Gets Scanned

### Secrets Detection

Trivy scans for:
- AWS Access Keys
- GitHub Personal Access Tokens
- SSH Private Keys
- Generic API Keys
- Database credentials
- OAuth tokens
- And many more...

### Vulnerability Detection

Trivy scans:
- Ruby gems (via Gemfile.lock)
- Transitive dependencies
- Known CVEs (CRITICAL, HIGH, MEDIUM severity)

## 📋 Security Best Practices

### ✅ DO:
- Run `./check_security.sh` before committing
- Keep dependencies updated regularly
- Review Trivy scan results in GitHub Security tab
- Use environment variables for sensitive config
- Add sensitive patterns to `.gitignore`

### ❌ DON'T:
- Commit API keys, tokens, or passwords
- Commit private keys or certificates
- Commit `.env` files
- Ignore security warnings without investigation
- Disable security scans

## 🔧 Configuration Files

- `.trivyignore` - CVEs to ignore (use with caution)
- `.trivyconfig.yaml` - Trivy scan configuration
- `.trivy-secret.yaml` - Custom secret patterns
- `.gitignore` - Protected file patterns
- `.github/workflows/deploy.yml` - CI/CD security pipeline

## 📊 Monitoring

### GitHub Security Tab
View all security findings at:
```
https://github.com/rodrigodlima/rodrigodlima.github.io/security
```

### Actions Tab
Monitor security scans at:
```
https://github.com/rodrigodlima/rodrigodlima.github.io/actions
```

## 🐛 Reporting Security Issues

If you discover a security vulnerability:

1. **DO NOT** open a public issue
2. Email: rodrigodlima@gmail.com
3. Include:
   - Description of the vulnerability
   - Steps to reproduce
   - Potential impact
   - Suggested fix (if any)

## 🔄 Security Updates

- Trivy database is updated automatically on every scan
- GitHub Actions uses latest stable versions
- Dependencies should be reviewed monthly

## 📚 Resources

- [Trivy Documentation](https://aquasecurity.github.io/trivy/)
- [GitHub Security Best Practices](https://docs.github.com/en/code-security)
- [OWASP Top 10](https://owasp.org/www-project-top-ten/)

## ✅ Security Checklist

Before publishing new content:

- [ ] Run `./check_security.sh` locally
- [ ] No secrets in code or config files
- [ ] GitHub Actions security scan passed
- [ ] No high/critical vulnerabilities unaddressed
- [ ] Sensitive files in `.gitignore`
- [ ] Review dependencies regularly

---

**Last Updated**: 2025-11-26
