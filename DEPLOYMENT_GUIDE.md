# Free Cloud Deployment Guide - Campaign Management System

## 🌟 Best Free Hosting Options

### Option 1: Render.com (RECOMMENDED ⭐)
**Best for:** Full-stack apps with database
- ✅ Free tier includes: 750 hours/month
- ✅ Automatic HTTPS
- ✅ Easy deployment from GitHub
- ✅ Supports SQLite (persistent disk)
- ✅ Environment variables support
- ⚠️ Sleeps after 15 min inactivity (wakes on request)

### Option 2: Railway.app
**Best for:** Quick deployment
- ✅ $5 free credit/month
- ✅ Very easy setup
- ✅ Automatic deployments
- ✅ Great for testing
- ⚠️ Limited free tier

### Option 3: Vercel (Frontend) + Render (Backend)
**Best for:** Separate frontend/backend
- ✅ Vercel: Unlimited bandwidth for frontend
- ✅ Render: Free backend hosting
- ✅ Best performance
- ⚠️ Requires separate deployments

---

## 🚀 RECOMMENDED: Deploy to Render.com

This is the easiest option for your full-stack app with SQLite database.

### Prerequisites
1. GitHub account
2. Render.com account (free)
3. Your code pushed to GitHub

---

## Step-by-Step: Render.com Deployment

### Step 1: Prepare Your Code for Deployment

#### 1.1 Update package.json (Backend)

Edit `backend/package.json` and ensure you have:

```json
{
  "name": "campaign-backend",
  "version": "1.0.0",
  "scripts": {
    "start": "node server.js",
    "dev": "nodemon server.js"
  },
  "engines": {
    "node": ">=18.0.0"
  }
}
```

#### 1.2 Create Build Script (Frontend)

Your `frontend/package.json` should have:

```json
{
  "scripts": {
    "start": "react-scripts start",
    "build": "react-scripts build",
    "test": "react-scripts test",
    "eject": "react-scripts eject"
  }
}
```

#### 1.3 Update Frontend API URL

Edit `frontend/src/services/api.js`:

```javascript
// Change this line:
const API_URL = process.env.REACT_APP_API_URL || 'http://localhost:3001/api';

// To support production:
const API_URL = process.env.REACT_APP_API_URL || 
  (process.env.NODE_ENV === 'production' 
    ? 'https://your-backend-url.onrender.com/api'  // Will update this later
    : 'http://localhost:3001/api');
```

#### 1.4 Update Backend Server for Production

Edit `backend/server.js` - add this BEFORE the routes:

```javascript
// Serve React frontend in production
if (process.env.NODE_ENV === 'production') {
  app.use(express.static(path.join(__dirname, '../frontend/build')));
  
  // Handle React routing - return all requests to React app
  app.get('*', (req, res) => {
    res.sendFile(path.join(__dirname, '../frontend/build', 'index.html'));
  });
}
```

This is already in your code, so you're good! ✅

### Step 2: Push Code to GitHub

```bash
cd elections-system

# Initialize git (if not already done)
git init

# Add all files
git add .

# Commit
git commit -m "Prepare for Render deployment"

# Create GitHub repo and push
# (Follow GitHub instructions to create a new repository)
git remote add origin https://github.com/YOUR_USERNAME/campaign-system.git
git branch -M main
git push -u origin main
```

### Step 3: Deploy Backend on Render

1. **Go to [Render.com](https://render.com)** and sign up/login

2. **Click "New +" → "Web Service"**

3. **Connect your GitHub repository**
   - Authorize Render to access your GitHub
   - Select your `campaign-system` repository

4. **Configure the service:**
   ```
   Name: campaign-backend
   Region: Choose closest to you
   Branch: main
   Root Directory: backend
   Runtime: Node
   Build Command: npm install
   Start Command: npm start
   ```

5. **Add Environment Variables:**
   Click "Advanced" → "Add Environment Variable"
   
   ```
   NODE_ENV=production
   JWT_SECRET=your-super-secret-key-change-this-in-production
   PORT=3001
   EVOLUTION_API_URL=http://your-evolution-api-url:8080
   EVOLUTION_API_KEY=your-evolution-api-key
   EVOLUTION_INSTANCE=your-instance-name
   FRONTEND_URL=https://your-backend-url.onrender.com
   ```

6. **Select Free Plan**

7. **Click "Create Web Service"**

8. **Wait for deployment** (5-10 minutes)
   - Render will install dependencies and start your server
   - You'll get a URL like: `https://campaign-backend-xxxx.onrender.com`

9. **Test the backend:**
   ```
   https://campaign-backend-xxxx.onrender.com/api/health
   ```
   Should return: `{"status":"ok","timestamp":"..."}`

### Step 4: Build and Deploy Frontend

#### Option A: Deploy Frontend with Backend (Single Service)

This is simpler - serve React from the same Node.js server.

1. **Build the frontend locally:**
   ```bash
   cd frontend
   npm install
   npm run build
   ```

2. **Commit the build folder:**
   ```bash
   git add -f frontend/build
   git commit -m "Add production build"
   git push
   ```

3. **Update Render build command:**
   - Go to your Render service settings
   - Change Build Command to:
   ```
   cd ../frontend && npm install && npm run build && cd ../backend && npm install
   ```

4. **Redeploy** - Render will automatically redeploy

5. **Access your app:**
   ```
   https://campaign-backend-xxxx.onrender.com
   ```

#### Option B: Deploy Frontend Separately on Vercel (Better Performance)

1. **Go to [Vercel.com](https://vercel.com)** and sign up

2. **Click "Add New" → "Project"**

3. **Import your GitHub repository**

4. **Configure:**
   ```
   Framework Preset: Create React App
   Root Directory: frontend
   Build Command: npm run build
   Output Directory: build
   ```

5. **Add Environment Variable:**
   ```
   REACT_APP_API_URL=https://campaign-backend-xxxx.onrender.com/api
   ```

6. **Deploy**

7. **You'll get a URL like:**
   ```
   https://campaign-system-xxxx.vercel.app
   ```

### Step 5: Update CORS Settings

Edit `backend/server.js`:

```javascript
// Update CORS configuration
app.use(cors({
  origin: [
    'http://localhost:3000',
    'https://campaign-backend-xxxx.onrender.com',
    'https://campaign-system-xxxx.vercel.app'  // If using Vercel
  ],
  credentials: true
}));
```

Commit and push:
```bash
git add .
git commit -m "Update CORS for production"
git push
```

### Step 6: Test Your Deployed App

1. **Open your app URL**
2. **Login with default credentials:**
   - Username: `admin`
   - Password: `admin123`
3. **Test all features:**
   - Create members
   - Create campaigns
   - Create broadcasts
   - Check dashboard

---

## 🔧 Alternative: Railway.app Deployment

### Quick Deploy to Railway

1. **Go to [Railway.app](https://railway.app)**

2. **Click "Start a New Project"**

3. **Select "Deploy from GitHub repo"**

4. **Select your repository**

5. **Railway will auto-detect Node.js**

6. **Add Environment Variables:**
   - Go to Variables tab
   - Add all your .env variables

7. **Deploy!**

Railway will give you a URL like: `https://campaign-system.up.railway.app`

---

## 🌐 Alternative: Vercel + Supabase (PostgreSQL)

If you want to use PostgreSQL instead of SQLite:

### 1. Create Supabase Account
- Go to [Supabase.com](https://supabase.com)
- Create new project (free tier)
- Get your PostgreSQL connection string

### 2. Update Database Code
- Replace `better-sqlite3` with `pg` (PostgreSQL)
- Update database.js to use PostgreSQL

### 3. Deploy Backend to Vercel
- Vercel supports Node.js serverless functions
- Deploy as serverless API

---

## 📱 Evolution API Hosting

For WhatsApp functionality, you need to host Evolution API separately:

### Option 1: Use Existing Evolution API Service
- If you have Evolution API running somewhere, just use that URL

### Option 2: Host Evolution API on Render
1. Fork Evolution API repository
2. Deploy to Render as separate service
3. Use the Render URL in your backend env variables

### Option 3: Use Evolution API Cloud Service
- Some providers offer hosted Evolution API
- Just get the API URL and key

---

## 🔒 Security Checklist Before Going Live

- [ ] Change default admin password
- [ ] Set strong JWT_SECRET (use random string generator)
- [ ] Update CORS to only allow your domains
- [ ] Enable HTTPS (automatic on Render/Vercel)
- [ ] Don't commit .env files to GitHub
- [ ] Use environment variables for all secrets
- [ ] Set up database backups (Render has persistent disk)

---

## 💾 Database Persistence on Render

**IMPORTANT:** By default, Render's free tier doesn't persist files.

To persist your SQLite database:

1. **Go to your Render service**
2. **Click "Disks" in the sidebar**
3. **Add Disk:**
   ```
   Name: database
   Mount Path: /opt/render/project/src/backend
   Size: 1GB (free tier)
   ```
4. **Redeploy**

Now your database will persist across deployments!

---

## 🧪 Testing Your Deployed App

### Test Checklist

1. **Backend Health Check:**
   ```bash
   curl https://your-backend-url.onrender.com/api/health
   ```

2. **Login Test:**
   ```bash
   curl -X POST https://your-backend-url.onrender.com/api/auth/login \
     -H "Content-Type: application/json" \
     -d '{"username":"admin","password":"admin123"}'
   ```

3. **Frontend Access:**
   - Open your app URL in browser
   - Login should work
   - Dashboard should load

4. **Database Test:**
   - Create a member
   - Refresh the page
   - Member should still be there (persistence test)

---

## 🐛 Troubleshooting

### Issue: "Cannot connect to backend"
**Solution:**
- Check REACT_APP_API_URL is correct
- Check CORS settings in backend
- Check backend is running (visit /api/health)

### Issue: "Database resets on every deploy"
**Solution:**
- Add persistent disk on Render (see above)
- Make sure mount path is correct

### Issue: "App sleeps/slow to wake"
**Solution:**
- This is normal on free tier
- First request after 15 min will be slow
- Consider upgrading to paid tier ($7/month) for always-on

### Issue: "WhatsApp messages not sending"
**Solution:**
- Check Evolution API is accessible from Render
- Verify Evolution API credentials
- Check Evolution API logs

---

## 💰 Cost Summary

### Completely Free Option:
- **Render.com:** Free tier (with sleep)
- **Total:** $0/month
- **Limitations:** Sleeps after 15 min, 750 hours/month

### Best Free Option:
- **Vercel:** Frontend (free, unlimited)
- **Render:** Backend (free, with sleep)
- **Total:** $0/month
- **Better performance than single service**

### Recommended Paid Option:
- **Render:** $7/month (always-on, no sleep)
- **Vercel:** Free (frontend)
- **Total:** $7/month
- **Best for production use**

---

## 🎯 Quick Start Commands

```bash
# 1. Prepare code
cd elections-system
git add .
git commit -m "Prepare for deployment"
git push

# 2. Build frontend
cd frontend
npm run build

# 3. Test locally in production mode
cd ../backend
NODE_ENV=production npm start
# Visit http://localhost:3001

# 4. Deploy to Render
# (Use Render dashboard - no CLI needed)

# 5. Test deployed app
curl https://your-app.onrender.com/api/health
```

---

## 📞 Need Help?

If you encounter issues:
1. Check Render logs (in dashboard)
2. Check browser console for errors
3. Verify environment variables are set
4. Test backend API endpoints directly
5. Check CORS configuration

---

## 🎉 You're Done!

Your Campaign Management System is now live and accessible from anywhere!

**Next Steps:**
1. Share the URL with your team
2. Change the default admin password
3. Import your member data
4. Create your first campaign
5. Send test broadcasts

**Your Live URLs:**
- Frontend: `https://your-app.onrender.com` or `https://your-app.vercel.app`
- Backend API: `https://your-backend.onrender.com/api`
- Health Check: `https://your-backend.onrender.com/api/health`
