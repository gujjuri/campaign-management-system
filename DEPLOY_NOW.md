# 🚀 Deploy to Render.com - Step-by-Step Guide

## ✅ Step 1: Git Repository Ready!

Your code is already committed and ready to push! ✅

```
✓ Git initialized
✓ All files committed
✓ Branch: main
✓ Ready to push to GitHub
```

---

## 📤 Step 2: Push to GitHub

### Option A: Create New Repository on GitHub (Recommended)

1. **Go to GitHub:** https://github.com/new

2. **Fill in repository details:**
   ```
   Repository name: campaign-management-system
   Description: Campaign Management System with WhatsApp Integration
   Visibility: Public (or Private - both work)
   
   ⚠️ DO NOT check:
   - Add a README file
   - Add .gitignore
   - Choose a license
   
   (We already have these files!)
   ```

3. **Click "Create repository"**

4. **Copy the commands shown** (they'll look like this):
   ```bash
   git remote add origin https://github.com/YOUR_USERNAME/campaign-management-system.git
   git push -u origin main
   ```

5. **Run these commands in your terminal:**
   ```bash
   cd /mnt/workspace/XwYbBVnDBPQ6C7fZJhr77QadkRXoJhH6rGRsx6A62hvY2K2Ei6mQe/elections-system
   
   # Add your GitHub repository (replace YOUR_USERNAME)
   git remote add origin https://github.com/YOUR_USERNAME/campaign-management-system.git
   
   # Push to GitHub
   git push -u origin main
   ```

6. **Enter your GitHub credentials** when prompted

✅ **Your code is now on GitHub!**

---

## 🌐 Step 3: Deploy to Render.com

### 3.1 Create Render Account

1. **Go to:** https://render.com
2. **Click "Get Started"**
3. **Sign up with GitHub** (easiest option)
4. **Authorize Render** to access your GitHub

### 3.2 Create Web Service

1. **Click "New +"** (top right)
2. **Select "Web Service"**
3. **Connect your repository:**
   - You'll see a list of your GitHub repositories
   - Find: `campaign-management-system`
   - Click **"Connect"**

### 3.3 Configure Service Settings

Fill in these exact settings:

| Setting | Value |
|---------|-------|
| **Name** | `campaign-system` (or any name you like) |
| **Region** | Choose closest to you (e.g., Oregon, Frankfurt) |
| **Branch** | `main` |
| **Root Directory** | Leave **EMPTY** |
| **Runtime** | `Node` |
| **Build Command** | `cd backend && npm install && cd ../frontend && npm install && npm run build && cd ../backend` |
| **Start Command** | `cd backend && npm start` |

### 3.4 Add Environment Variables

**Click "Advanced"** → Scroll to **"Environment Variables"**

Click **"Add Environment Variable"** and add these **one by one**:

```
Key: NODE_ENV
Value: production
```

```
Key: JWT_SECRET
Value: campaign-secret-key-change-this-in-production-12345
```

```
Key: PORT
Value: 3001
```

```
Key: EVOLUTION_API_URL
Value: http://localhost:8080
```
*(You can update this later when you have Evolution API)*

```
Key: EVOLUTION_API_KEY
Value: your-api-key
```
*(You can update this later)*

```
Key: EVOLUTION_INSTANCE
Value: your-instance
```
*(You can update this later)*

### 3.5 Add Persistent Disk (IMPORTANT!)

**Scroll down to "Disk" section:**

1. Click **"Add Disk"**
2. Fill in:
   ```
   Name: database
   Mount Path: /opt/render/project/src/backend
   Size: 1 GB
   ```
3. Click **"Save"**

**This ensures your database persists!** Without this, your data will be lost on every deploy.

### 3.6 Select Plan

- **Plan:** Select **"Free"**
- **Auto-Deploy:** Leave **ON** (deploys automatically when you push to GitHub)

### 3.7 Deploy!

1. **Click "Create Web Service"**
2. **Wait for deployment** (5-10 minutes)

You'll see logs like:
```
==> Cloning from https://github.com/YOUR_USERNAME/campaign-management-system...
==> Running build command: cd backend && npm install...
==> Installing dependencies...
==> Building frontend...
==> Starting server...
```

---

## ⏳ Step 4: Wait for Deployment

### What's Happening:

1. ✅ Cloning your code from GitHub
2. ✅ Installing backend dependencies (npm install)
3. ✅ Installing frontend dependencies
4. ✅ Building React frontend (npm run build)
5. ✅ Starting Node.js server

### When Complete:

You'll see:
```
╔═══════════════════════════════════════════════════════════╗
║     Campaign Management System                             ║
║     Server running on http://localhost:3001               ║
╠═══════════════════════════════════════════════════════════╣
║  Default Admin Login:                                      ║
║  Username: admin                                           ║
║  Password: admin123                                        ║
╚═══════════════════════════════════════════════════════════╝

Your service is live 🎉
```

**Status will change to:** ✅ **Live**

---

## 🎉 Step 5: Test Your Live App!

### Your App URL

Render gives you a URL like:
```
https://campaign-system-xxxx.onrender.com
```

You'll find it at the top of your Render dashboard.

### Test It:

#### 1. Health Check
Open in browser:
```
https://campaign-system-xxxx.onrender.com/api/health
```

Should show:
```json
{"status":"ok","timestamp":"2026-03-11T..."}
```

#### 2. Open the App
```
https://campaign-system-xxxx.onrender.com
```

You should see the **Login Page**!

#### 3. Login
```
Username: admin
Password: admin123
```

#### 4. Test Features

- ✅ Dashboard loads
- ✅ Create a member
- ✅ Refresh page - member still there (database persistence!)
- ✅ Create a campaign
- ✅ Add members to campaign
- ✅ Create a broadcast

---

## ⚠️ Important Notes

### Free Tier Behavior

**Your app will sleep after 15 minutes of inactivity.**

- First request after sleep: ~30 seconds to wake up
- Subsequent requests: Fast!
- This is normal on free tier

**To keep it always-on:** Upgrade to Starter plan ($7/month)

### First Request is Slow

When you first visit (or after 15 min):
- Wait 20-30 seconds
- Don't refresh! Just wait
- It's waking up from sleep
- After that, it's fast

### Database Persistence

✅ **With the disk we added, your data persists!**
- Members stay
- Campaigns stay
- Everything persists across deployments

---

## 🔧 Troubleshooting

### Issue: "Application failed to respond"

**Solution:** 
- Wait 30 seconds (it's waking from sleep)
- Refresh the page
- Check Render logs for errors

### Issue: Build Failed

**Solution:**
1. Check the logs in Render dashboard
2. Look for error messages
3. Common issues:
   - Missing dependencies → Check package.json
   - Build command wrong → Verify it matches above
   - Node version → Should auto-detect

### Issue: Can't Login

**Solution:**
1. Check browser console (F12)
2. Verify JWT_SECRET is set in environment variables
3. Try clearing browser cache
4. Check API health endpoint first

### Issue: Database Resets

**Solution:**
- Make sure you added the persistent disk
- Verify mount path: `/opt/render/project/src/backend`
- Check disk is attached in Render dashboard

---

## 📱 Share Your App

Your app is now live! Share with your team:

```
🌐 App URL: https://campaign-system-xxxx.onrender.com

👤 Login:
Username: admin
Password: admin123

⚠️ Change password after first login!
```

---

## 🔐 Security Checklist

After deployment:

- [ ] Login and change admin password
- [ ] Go to Settings → Update Password
- [ ] Use a strong password
- [ ] Update JWT_SECRET to a random string (in Render env vars)
- [ ] Configure Evolution API when ready

---

## 🎯 Next Steps

### 1. Change Admin Password
```
Login → Settings → Update Password
```

### 2. Import Members
```
Members → Import CSV
```

Sample CSV format:
```csv
full_name,phone,email,whatsapp_number,address,city,state,postal_code,country
John Doe,+1234567890,john@example.com,+1234567890,123 Main St,New York,NY,10001,USA
```

### 3. Create Your First Campaign
```
Campaigns → Create Campaign → Add Members
```

### 4. Send Test Broadcast
```
Broadcasts → Create Broadcast → Add Recipients → Send
```

### 5. Configure WhatsApp (When Ready)

Update environment variables in Render:
1. Go to your service in Render
2. Click "Environment" tab
3. Update:
   - EVOLUTION_API_URL
   - EVOLUTION_API_KEY
   - EVOLUTION_INSTANCE
4. Save (will auto-redeploy)

---

## 💰 Upgrade Options

### Current: Free Tier
- ✅ Free forever
- ⚠️ Sleeps after 15 min
- ✅ 750 hours/month
- ✅ 1GB database

### Upgrade: Starter ($7/month)
- ✅ Always-on (no sleep!)
- ✅ 512MB RAM
- ✅ Better performance
- ✅ Perfect for production

To upgrade:
1. Render dashboard → Your service
2. Click "Upgrade"
3. Select "Starter"

---

## 🆘 Need Help?

### Check Logs
1. Render dashboard → Your service
2. Click "Logs" tab
3. See real-time logs

### Test API Directly
```bash
# Health check
curl https://your-app.onrender.com/api/health

# Login test
curl -X POST https://your-app.onrender.com/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"username":"admin","password":"admin123"}'
```

### Common Commands

**View logs:**
- Render dashboard → Logs tab

**Restart service:**
- Render dashboard → Manual Deploy → Deploy latest commit

**Update environment variables:**
- Render dashboard → Environment tab → Edit

---

## ✅ Success Checklist

- [ ] GitHub repository created
- [ ] Code pushed to GitHub
- [ ] Render account created
- [ ] Web service created
- [ ] Environment variables set
- [ ] Persistent disk added
- [ ] Deployment successful
- [ ] Health check returns OK
- [ ] Can login to app
- [ ] Dashboard loads
- [ ] Can create member
- [ ] Member persists after refresh

**All checked?** 🎉 **You're live!**

---

## 🎊 Congratulations!

Your Campaign Management System is now **LIVE ON THE INTERNET!**

**Your URLs:**
- 🌐 **App:** https://campaign-system-xxxx.onrender.com
- 🔧 **API:** https://campaign-system-xxxx.onrender.com/api
- ❤️ **Health:** https://campaign-system-xxxx.onrender.com/api/health

**What you can do now:**
- ✅ Access from anywhere in the world
- ✅ Share with your team
- ✅ Import real member data
- ✅ Create campaigns
- ✅ Send WhatsApp broadcasts (once Evolution API configured)

**Enjoy your Campaign Management System!** 🚀
