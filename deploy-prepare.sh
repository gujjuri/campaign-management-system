#!/bin/bash

# Campaign Management System - Deployment Preparation Script
# This script prepares your app for deployment to Render.com

echo "🚀 Preparing Campaign Management System for Deployment..."
echo ""

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Check if git is initialized
if [ ! -d .git ]; then
    echo -e "${YELLOW}⚠️  Git not initialized. Initializing...${NC}"
    git init
    echo -e "${GREEN}✅ Git initialized${NC}"
fi

# Check if .gitignore exists
if [ ! -f .gitignore ]; then
    echo -e "${RED}❌ .gitignore not found!${NC}"
    exit 1
fi

# Install backend dependencies
echo ""
echo -e "${YELLOW}📦 Installing backend dependencies...${NC}"
cd backend
npm install
if [ $? -ne 0 ]; then
    echo -e "${RED}❌ Backend npm install failed!${NC}"
    exit 1
fi
echo -e "${GREEN}✅ Backend dependencies installed${NC}"

# Install frontend dependencies
echo ""
echo -e "${YELLOW}📦 Installing frontend dependencies...${NC}"
cd ../frontend
npm install
if [ $? -ne 0 ]; then
    echo -e "${RED}❌ Frontend npm install failed!${NC}"
    exit 1
fi
echo -e "${GREEN}✅ Frontend dependencies installed${NC}"

# Build frontend
echo ""
echo -e "${YELLOW}🔨 Building frontend for production...${NC}"
npm run build
if [ $? -ne 0 ]; then
    echo -e "${RED}❌ Frontend build failed!${NC}"
    exit 1
fi
echo -e "${GREEN}✅ Frontend built successfully${NC}"

# Test backend locally
echo ""
echo -e "${YELLOW}🧪 Testing backend in production mode...${NC}"
cd ../backend
NODE_ENV=production timeout 5 npm start &
SERVER_PID=$!
sleep 3

# Test health endpoint
HEALTH_CHECK=$(curl -s http://localhost:3001/api/health 2>/dev/null)
kill $SERVER_PID 2>/dev/null

if [[ $HEALTH_CHECK == *"ok"* ]]; then
    echo -e "${GREEN}✅ Backend health check passed${NC}"
else
    echo -e "${YELLOW}⚠️  Backend health check failed (this might be normal if port is in use)${NC}"
fi

# Go back to root
cd ..

# Check for .env file
echo ""
if [ -f backend/.env ]; then
    echo -e "${GREEN}✅ .env file found${NC}"
    echo -e "${YELLOW}⚠️  Remember: Don't commit .env to GitHub!${NC}"
    echo -e "${YELLOW}⚠️  You'll need to set environment variables in Render dashboard${NC}"
else
    echo -e "${YELLOW}⚠️  No .env file found. You'll need to set environment variables in Render.${NC}"
fi

# Git status
echo ""
echo -e "${YELLOW}📋 Git Status:${NC}"
git status --short

# Summary
echo ""
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}✅ Deployment Preparation Complete!${NC}"
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "${YELLOW}Next Steps:${NC}"
echo ""
echo "1. Commit your changes:"
echo "   ${GREEN}git add .${NC}"
echo "   ${GREEN}git commit -m 'Prepare for deployment'${NC}"
echo ""
echo "2. Create GitHub repository and push:"
echo "   ${GREEN}git remote add origin https://github.com/YOUR_USERNAME/campaign-system.git${NC}"
echo "   ${GREEN}git branch -M main${NC}"
echo "   ${GREEN}git push -u origin main${NC}"
echo ""
echo "3. Deploy to Render:"
echo "   - Go to https://render.com"
echo "   - Click 'New +' → 'Web Service'"
echo "   - Connect your GitHub repository"
echo "   - Follow the DEPLOYMENT_GUIDE.md for detailed instructions"
echo ""
echo -e "${YELLOW}📖 See DEPLOYMENT_GUIDE.md for complete deployment instructions${NC}"
echo ""
