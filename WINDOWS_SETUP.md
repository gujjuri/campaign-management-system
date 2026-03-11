# 🪟 Windows Setup Guide - Install Git & Deploy

## ⚠️ Git Not Installed

You're on Windows and Git is not installed. Let's fix that!

---

## Option 1: Install Git for Windows (Recommended)

### Step 1: Download Git

1. **Go to:** https://git-scm.com/download/win
2. **Download** will start automatically
3. **Run the installer** (Git-2.x.x-64-bit.exe)

### Step 2: Install Git

**Installation Settings (just click Next for most):**

1. **Select Components:**
   - ✓ Windows Explorer integration
   - ✓ Git Bash Here
   - ✓ Git GUI Here
   - Click **Next**

2. **Default Editor:**
   - Select "Use Visual Studio Code" or "Use Notepad"
   - Click **Next**

3. **PATH Environment:**
   - Select **"Git from the command line and also from 3rd-party software"**
   - Click **Next**

4. **HTTPS Backend:**
   - Select "Use the OpenSSL library"
   - Click **Next**

5. **Line Ending:**
   - Select "Checkout Windows-style, commit Unix-style"
   - Click **Next**

6. **Terminal Emulator:**
   - Select "Use MinTTY"
   - Click **Next**

7. **Click "Install"**

8. **Click "Finish"**

### Step 3: Verify Installation

**Open PowerShell or Command Prompt and run:**

```powershell
git --version
```

Should show: `git version 2.x.x`

✅ **Git is now installed!**

---

## Option 2: Use GitHub Desktop (Easiest for Windows)

### Step 1: Download GitHub Desktop

1. **Go to:** https://desktop.github.com
2. **Click "Download for Windows"**
3. **Run the installer**

### Step 2: Login to GitHub

1. **Open GitHub Desktop**
2. **Click "Sign in to GitHub.com"**
3. **Enter credentials:**
   - Email: gujjuri@gmail.com
   - Password: (your GitHub password)
4. **Click "Sign in"**

### Step 3: Add Your Repository

1. **Click "File" → "Add local repository"**
2. **Browse to:**
   ```
   C:\Users\YourName\...\elections-system
   ```
   (Or wherever your project folder is)
3. **Click "Add repository"**

### Step 4: Publish to GitHub

1. **Click "Publish repository"**
2. **Fill in:**
   ```
   Name: campaign-management-system
   Description: Campaign Management System with WhatsApp Integration
   ☐ Keep this code private (uncheck for public)
   ```
3. **Click "Publish repository"**

✅ **Your code is now on GitHub!**

---

## Option 3: Upload Directly to GitHub (Quick & Easy)

### Step 1: Create Repository on GitHub

1. **Go to:** https://github.com/new
2. **Fill in:**
   ```
   Repository name: campaign-management-system
   Description: Campaign Management System with WhatsApp Integration
   Visibility: Public
   
   ⚠️ DO NOT check any boxes!
   ```
3. **Click "Create repository"**

### Step 2: Upload Files

1. **On the repository page, click "uploading an existing file"**
2. **Drag and drop your entire `elections-system` folder**
3. **Or click "choose your files" and select all files**
4. **Scroll down and click "Commit changes"**

✅ **Your code is now on GitHub!**

---

## 🎯 After Git is Installed / Code is Uploaded

### Next Steps:

1. **Verify your code is on GitHub:**
   - Go to: `https://github.com/YOUR_USERNAME/campaign-management-system`
   - You should see all your files

2. **Continue to Render deployment:**
   - Open: `DEPLOY_NOW.md`
   - Follow Step 3 onwards

---

## 🔧 Configure Git (After Installation)

If you installed Git, configure it:

```powershell
# Open PowerShell and run:
git config --global user.email "gujjuri@gmail.com"
git config --global user.name "Gujjuri"
```

---

## 📤 Push to GitHub (After Git Installation)

```powershell
# Navigate to your project
cd path\to\elections-system

# Check status
git status

# Add remote (replace YOUR_USERNAME)
git remote add origin https://github.com/YOUR_USERNAME/campaign-management-system.git

# Push to GitHub
git push -u origin main
```

**When prompted for credentials:**
- Username: Your GitHub username
- Password: Your Personal Access Token (NOT your password!)
  - Get token: https://github.com/settings/tokens

---

## 🆘 Troubleshooting

### Issue: "git is not recognized"

**Solution:**
1. Restart PowerShell/Command Prompt after installing Git
2. Or use Git Bash (installed with Git for Windows)
3. Or use GitHub Desktop instead

### Issue: "Authentication failed"

**Solution:**
- GitHub no longer accepts passwords
- You need a Personal Access Token
- Get it: https://github.com/settings/tokens
- Use token as password when pushing

### Issue: "Can't find project folder"

**Solution:**
- Your project is in: `/mnt/workspace/XwYbBVnDBPQ6C7fZJhr77QadkRXoJhH6rGRsx6A62hvY2K2Ei6mQe/elections-system`
- This is a Linux path (you're using WSL or similar)
- Access it from Windows at: `\\wsl$\Ubuntu\mnt\workspace\...`

---

## 💡 Recommended Approach for Windows

### Easiest Method:

1. **Install GitHub Desktop** (https://desktop.github.com)
2. **Login to GitHub**
3. **Add your local repository**
4. **Publish to GitHub**
5. **Continue to Render deployment**

**Why?** No command line needed, visual interface, easier for Windows users.

---

## 🚀 Quick Path Forward

### If you want to use Git command line:

1. ✅ Install Git for Windows
2. ✅ Restart PowerShell
3. ✅ Configure Git
4. ✅ Push to GitHub
5. ✅ Deploy to Render

### If you want the easiest way:

1. ✅ Install GitHub Desktop
2. ✅ Login
3. ✅ Publish repository
4. ✅ Deploy to Render

### If you want the quickest way:

1. ✅ Create GitHub repository
2. ✅ Upload files via web interface
3. ✅ Deploy to Render

---

## 📋 What You Need

- [ ] Git installed (or GitHub Desktop)
- [ ] GitHub account
- [ ] Personal Access Token (for command line)
- [ ] Your project files

---

## 🎯 Next Steps

1. **Choose your method above**
2. **Get your code on GitHub**
3. **Open `DEPLOY_NOW.md`**
4. **Deploy to Render**
5. **🎉 You're live!**

---

## 📞 Quick Links

- **Git for Windows:** https://git-scm.com/download/win
- **GitHub Desktop:** https://desktop.github.com
- **GitHub:** https://github.com
- **Create Token:** https://github.com/settings/tokens
- **Render:** https://render.com

---

## ✅ Recommended: GitHub Desktop

For Windows users, **GitHub Desktop is the easiest option**:

1. No command line needed
2. Visual interface
3. Easy authentication
4. One-click publish
5. Perfect for beginners

**Download:** https://desktop.github.com

---

**Choose your method and let's get your code on GitHub!** 🚀
