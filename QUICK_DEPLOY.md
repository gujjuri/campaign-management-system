# 🚀 Quick Deploy to Render.com (5 Minutes)

## Prerequisites
- [ ] GitHub account
- [ ] Render.com account (sign up at https://render.com - it's free!)

---

## Step 1: Push to GitHub (2 minutes)

```bash
# Navigate to your project
cd elections-system

# Initialize git (if not done)
git init

# Add all files
git add .

# Commit
git commit -m "Initial commit - Campaign Management System"

# Create a new repository on GitHub
# Go to https://github.com/new
# Name it: campaign-system
# Don't initialize with README (we already have code)

# Add remote and push
git remote add origin https://github.com/YOUR_USERNAME/campaign-system.git
git branch -M main
git push -u origin main
```

✅ **Your code is now on GitHub!**

---

## Step 2: Deploy to Render (3 minutes)

### 2.1 Create Web Service

1. Go to **https://render.com/dashboard**
2. Click **"New +"** → **"Web Service"**
3. Click **"Connect GitHub"** and authorize Render
4. Select your **campaign-system** repository
5. Click **"Connect"**

### 2.2 Configure Service

Fill in these settings:

| Setting | Value |
|---------|-------|
| **Name** | `campaign-system` (or any name you like) |
| **Region** | Choose closest to you |
| **Branch** | `main` |
| **Root Directory** | Leave empty |
| **Runtime** | `Node` |
| **Build Command** | `cd backend && npm install && cd ../frontend && npm install && npm run build && cd ../backend` |
| **Start Command** | `cd backend && npm start` |
| **Plan** | `Free` |

### 2.3 Add Environment Variables

Click **"Advanced"** → **"Add Environment Variable"**

Add these variables:

```
NODE_ENV = production
JWT_SECRET = your-super-secret-key-change-this-123456
PORT = 3001
EVOLUTION_API_URL = http://your-evolution-api:8080
EVOLUTION_API_KEY = your-api-key
EVOLUTION_INSTANCE = your-instance
```

**Important:** 
- Change `JWT_SECRET` to a random string
- If you don't have Evolution API yet, you can add dummy values and update later

### 2.4 Add Persistent Disk (Important!)

Scroll down to **"Disk"** section:

1. Click **"Add Disk"**
2. Fill in:
   ```
   Name: database
   Mount Path: /opt/render/project/src/backend
   Size: 1 GB
   ```
3. Click **"Save"**

This ensures your database persists across deployments!

### 2.5 Deploy!

1. Click **"Create Web Service"**
2. Wait 5-10 minutes for deployment
3. Watch the logs - you'll see:
   - Installing dependencies
   - Building frontend
   - Starting server

---

## Step 3: Test Your App! 🎉

Once deployment is complete, you'll see:

```
╔═══════════════════════════════════════════════════════════╗
║     Campaign Management System                             ║
║     Server running on http://localhost:3001               ║
╠═══════════════════════════════════════════════════════════╣
║  Default Admin Login:                                      ║
║  Username: admin                                           ║
║  Password: admin123                                        ║
╚═══════════════════════════════════════════════════════════╝
```

### Your App URL

Render will give you a URL like:
```
https://campaign-system-xxxx.onrender.com
```

### Test It:

1. **Health Check:**
   ```
   https://campaign-system-xxxx.onrender.com/api/health
   ```
   Should show: `{"status":"ok","timestamp":"..."}`

2. **Open the App:**
   ```
   https://campaign-system-xxxx.onrender.com
   ```

3. **Login:**
   - Username: `admin`
   - Password: `admin123`

4. **🎉 You're live!**

---

## ⚠️ Important Notes

### Free Tier Limitations

- **Sleeps after 15 minutes** of inactivity
- First request after sleep takes ~30 seconds to wake up
- **750 hours/month** free (enough for testing)
- To keep it always-on, upgrade to $7/month

### First Request is Slow

When you first visit your app (or after 15 min of inactivity):
- It will take 20-30 seconds to load
- This is normal on free tier
- Subsequent requests are fast

### Database Persistence

✅ With the disk we added, your database will persist!
- Members you create will stay
- Campaigns will stay
- Everything persists across deployments

---

## 🔧 Common Issues

### Issue: "Application failed to respond"
**Solution:** Wait 30 seconds and refresh. Free tier apps sleep and need time to wake up.

### Issue: "Cannot connect to backend"
**Solution:** 
- Check the logs in Render dashboard
- Make sure build completed successfully
- Verify environment variables are set

### Issue: "Login doesn't work"
**Solution:**
- Check JWT_SECRET is set in environment variables
- Try clearing browser cache
- Check browser console for errors

### Issue: "Database resets on every deploy"
**Solution:**
- Make sure you added the persistent disk
- Verify mount path is: `/opt/render/project/src/backend`

---

## 🎯 Next Steps

### 1. Change Admin Password
```
Settings → Update Password
```

### 2. Import Members
```
Members → Import CSV
```

### 3. Create Campaign
```
Campaigns → Create Campaign → Add Members
```

### 4. Send Test Broadcast
```
Broadcasts → Create Broadcast → Add Recipients → Send
```

### 5. Configure WhatsApp (Optional)
- Set up Evolution API
- Update environment variables in Render
- Test WhatsApp integration

---

## 📱 Share Your App

Your app is now live! Share the URL with your team:

```
https://campaign-system-xxxx.onrender.com
```

**Default Login:**
- Username: `admin`
- Password: `admin123`

⚠️ **Remember to change the password after first login!**

---

## 💰 Upgrade to Always-On (Optional)

If you want your app to never sleep:

1. Go to Render dashboard
2. Select your service
3. Click "Upgrade"
4. Choose "Starter" plan ($7/month)
5. Your app will now be always-on with no sleep!

---

## 🆘 Need Help?

### Check Logs
1. Go to Render dashboard
2. Click on your service
3. Click "Logs" tab
4. See what's happening in real-time

### Test Backend Directly
```bash
# Health check
curl https://your-app.onrender.com/api/health

# Login test
curl -X POST https://your-app.onrender.com/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"username":"admin","password":"admin123"}'
```

### Check Environment Variables
1. Render dashboard → Your service
2. Click "Environment" tab
3. Verify all variables are set correctly

---

## 🎉 Congratulations!

Your Campaign Management System is now live on the internet!

**What you can do now:**
- ✅ Access from anywhere
- ✅ Share with your team
- ✅ Import real member data
- ✅ Create campaigns
- ✅ Send WhatsApp broadcasts (once Evolution API is configured)

**Your URLs:**
- **App:** https://campaign-system-xxxx.onrender.com
- **API:** https://campaign-system-xxxx.onrender.com/api
- **Health:** https://campaign-system-xxxx.onrender.com/api/health

---

## 📖 More Information

- **Full Deployment Guide:** See `DEPLOYMENT_GUIDE.md`
- **Testing Guide:** See `TEST_GUIDE.md`
- **Project Summary:** See `COMPLETION_SUMMARY.md`

Enjoy your Campaign Management System! 🚀
