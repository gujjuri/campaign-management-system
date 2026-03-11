# Campaign Management System - Testing Guide

## Prerequisites

1. **Install Dependencies**
   ```bash
   # Backend
   cd backend
   npm install
   
   # Frontend
   cd ../frontend
   npm install
   ```

2. **Configure Environment Variables**
   
   Create `backend/.env` file:
   ```env
   # Evolution API Configuration
   EVOLUTION_API_URL=http://localhost:8080
   EVOLUTION_API_KEY=your-api-key-here
   EVOLUTION_INSTANCE=your-instance-name
   
   # Server Configuration
   JWT_SECRET=your-secret-key-here
   PORT=3001
   FRONTEND_URL=http://localhost:3000
   ```

## Running the Application

### Start Backend Server
```bash
cd backend
npm start
```

Expected output:
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

### Start Frontend Development Server
```bash
cd frontend
npm start
```

The app should open at `http://localhost:3000`

## Test Scenarios

### 1. Login Test
- [ ] Navigate to `http://localhost:3000`
- [ ] Login with credentials:
  - Username: `admin`
  - Password: `admin123`
- [ ] Verify redirect to Dashboard

### 2. Dashboard Test
- [ ] Verify all stat cards display:
  - Total Members
  - Campaigns
  - Messages Sent
  - Delivery Rate
- [ ] Check "Recent Campaigns" section
- [ ] Check "Recent Broadcasts" section

### 3. Member Management Test

#### Import Members via CSV
- [ ] Navigate to "Members" page
- [ ] Click "Import CSV"
- [ ] Upload a CSV file with these columns:
  ```csv
  full_name,phone,email,whatsapp_number,address,city,state,postal_code,country,tags
  John Doe,+1234567890,john@example.com,+1234567890,123 Main St,New York,NY,10001,USA,supporter
  Jane Smith,+0987654321,jane@example.com,+0987654321,456 Oak Ave,Los Angeles,CA,90001,USA,volunteer
  ```
- [ ] Verify members are imported successfully
- [ ] Check that address fields are populated

#### Add Member Manually
- [ ] Click "Add Member"
- [ ] Fill in all fields including:
  - Full Name
  - Phone
  - Email
  - WhatsApp Number
  - Address, City, State, Postal Code, Country
  - Tags
- [ ] Save and verify member appears in list

#### Export Members
- [ ] Click "Export CSV"
- [ ] Verify downloaded CSV contains all members with address fields

### 4. Campaign Management Test

#### Create Campaign
- [ ] Navigate to "Campaigns" page
- [ ] Click "Create Campaign"
- [ ] Fill in campaign details:
  - Name: "Test Campaign 2026"
  - Description: "Testing campaign functionality"
  - Status: "draft"
  - Start Date: Today
  - End Date: 1 week from today
- [ ] Save campaign
- [ ] Verify campaign appears in list

#### Add Members to Campaign
- [ ] Click on the created campaign
- [ ] Click "Add Members"
- [ ] Select members from the list
- [ ] Click "Add Selected"
- [ ] Verify members appear in campaign member list

#### Add All Members to Campaign
- [ ] Click "Add All Members"
- [ ] Confirm action
- [ ] Verify all members are added to campaign

#### Update Campaign Status
- [ ] Change campaign status to "active"
- [ ] Save changes
- [ ] Verify status is updated

### 5. Broadcast Test

#### Create Text Broadcast
- [ ] Navigate to "Broadcasts" page
- [ ] Click "Create Broadcast"
- [ ] Fill in broadcast details:
  - Title: "Test Broadcast"
  - Message Type: "text"
  - Message: "Hello {name}, this is a test message!"
  - Campaign: Select the test campaign
- [ ] Save as draft
- [ ] Verify broadcast appears in list

#### Add Recipients
- [ ] Click on the created broadcast
- [ ] Click "Add Recipients"
- [ ] Select "From Campaign" and choose your test campaign
- [ ] Verify recipients are added

#### Send Broadcast (if Evolution API is configured)
- [ ] Click "Send Broadcast"
- [ ] Confirm action
- [ ] Monitor the broadcast detail page for status updates
- [ ] Check delivery status for each recipient

#### Create Media Broadcast
- [ ] Create new broadcast
- [ ] Select message type: "image" or "document"
- [ ] Upload a file
- [ ] Add caption with {name} placeholder
- [ ] Add recipients
- [ ] Send (if Evolution API configured)

### 6. WhatsApp Integration Test (Requires Evolution API)

#### Check WhatsApp Status
- [ ] Navigate to "Settings" page
- [ ] Check "WhatsApp Status" section
- [ ] Verify connection status

#### Send Test Message
- [ ] Enter a test phone number
- [ ] Enter a test message
- [ ] Click "Send Test"
- [ ] Verify message is sent

### 7. Settings Test

#### Update Profile
- [ ] Navigate to "Settings"
- [ ] Update username or password
- [ ] Save changes
- [ ] Verify changes are saved

#### Create New Operator
- [ ] Click "Add Operator"
- [ ] Fill in details:
  - Username
  - Password
  - Role: "operator"
- [ ] Save
- [ ] Logout and login with new operator credentials

## API Endpoint Tests (Using curl or Postman)

### Health Check
```bash
curl http://localhost:3001/api/health
```

Expected response:
```json
{
  "status": "ok",
  "timestamp": "2026-03-11T..."
}
```

### Login
```bash
curl -X POST http://localhost:3001/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"username":"admin","password":"admin123"}'
```

Expected response:
```json
{
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "user": {
    "id": 1,
    "username": "admin",
    "role": "admin"
  }
}
```

### Get Campaigns (with auth token)
```bash
curl http://localhost:3001/api/campaigns \
  -H "Authorization: Bearer YOUR_TOKEN_HERE"
```

### Get Dashboard Stats
```bash
curl http://localhost:3001/api/dashboard \
  -H "Authorization: Bearer YOUR_TOKEN_HERE"
```

## Common Issues & Solutions

### Issue: Database not initialized
**Solution:** Delete `backend/database.db` and restart the backend server. It will recreate the database with the default admin user.

### Issue: CORS errors
**Solution:** Ensure backend is running on port 3001 and frontend on port 3000. Check CORS configuration in `backend/server.js`.

### Issue: Evolution API connection failed
**Solution:** 
1. Verify Evolution API is running
2. Check `.env` configuration
3. Test Evolution API directly: `curl http://localhost:8080/instance/connectionState/YOUR_INSTANCE`

### Issue: CSV import fails
**Solution:** 
1. Ensure CSV has proper headers
2. Check phone numbers are in international format (+1234567890)
3. Verify file encoding is UTF-8

### Issue: Broadcasts not sending
**Solution:**
1. Check Evolution API configuration
2. Verify WhatsApp instance is connected
3. Check broadcast status in database
4. Review backend logs for errors

## Database Inspection

To inspect the database directly:
```bash
cd backend
sqlite3 database.db

# List all tables
.tables

# View campaigns
SELECT * FROM campaigns;

# View members
SELECT * FROM members;

# View broadcasts
SELECT * FROM broadcasts;

# View campaign members
SELECT c.name, m.full_name 
FROM campaigns c
JOIN campaign_members cm ON c.id = cm.campaign_id
JOIN members m ON cm.member_id = m.id;

# Exit
.quit
```

## Performance Testing

### Load Test: Import 1000 Members
1. Generate a CSV with 1000 members
2. Import via the UI
3. Verify import completes in < 10 seconds

### Load Test: Send Broadcast to 100 Recipients
1. Create campaign with 100 members
2. Create broadcast
3. Send to all recipients
4. Monitor delivery rate and time

## Security Testing

- [ ] Verify JWT token expiration
- [ ] Test unauthorized access to protected routes
- [ ] Verify password hashing (check database - passwords should be bcrypt hashes)
- [ ] Test SQL injection prevention (try malicious input in forms)
- [ ] Test XSS prevention (try script tags in text fields)

## Cleanup After Testing

```bash
# Stop servers (Ctrl+C in both terminal windows)

# Optional: Reset database
cd backend
rm database.db
npm start  # Will recreate with default admin user
```

## Next Steps After Testing

1. Configure Evolution API for production WhatsApp integration
2. Set up proper environment variables for production
3. Build frontend for production: `cd frontend && npm run build`
4. Deploy to production server
5. Set up SSL/TLS certificates
6. Configure backup strategy for database
7. Set up monitoring and logging
