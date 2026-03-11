# Campaign Management System

A comprehensive web application for managing election campaigns with WhatsApp integration via Evolution API. CRM operators can manage members, organize campaigns, and broadcast messages (text, images, PDFs) to members.

## Features

- **Member Management**
  - Import members from CSV files
  - Export members to CSV
  - Full address support for personal outreach
  - Tags for categorization
  - Search and filter members

- **Campaign Management**
  - Create and manage campaigns
  - Assign members to campaigns
  - Track campaign status

- **WhatsApp Broadcasting (via Evolution API)**
  - Send text messages
  - Send images with captions
  - Send PDF/document files
  - Personalized messages with `{name}` placeholder
  - Track delivery status

- **CRM Operator Panel**
  - Dashboard with statistics
  - User authentication
  - Role-based access (admin/operator)

## Tech Stack

- **Backend**: Node.js, Express.js, SQLite (better-sqlite3)
- **Frontend**: React, Tailwind CSS
- **WhatsApp**: Evolution API integration

## Prerequisites

- Node.js 18+ 
- Evolution API instance running and configured
- npm or yarn

## Installation

### 1. Clone and Setup

```bash
cd elections-system
```

### 2. Backend Setup

```bash
cd backend

# Install dependencies
npm install

# Copy environment file
cp .env.example .env

# Edit .env with your Evolution API credentials
```

### 3. Configure Environment Variables

Edit `backend/.env`:

```env
# Evolution API Configuration
EVOLUTION_API_URL=http://localhost:8080
EVOLUTION_API_KEY=your-evolution-api-key
EVOLUTION_INSTANCE=your-instance-name

# JWT Secret
JWT_SECRET=your-super-secret-jwt-key-change-in-production

# Server
PORT=3001
```

### 4. Frontend Setup

```bash
cd frontend

# Install dependencies
npm install
```

### 5. Start the Application

**Terminal 1 - Backend:**
```bash
cd backend
npm start
```

**Terminal 2 - Frontend:**
```bash
cd frontend
npm start
```

The application will be available at:
- Frontend: http://localhost:3000
- Backend API: http://localhost:3001

## Default Login

- **Username**: `admin`
- **Password**: `admin123`

## CSV Import Format

When importing members, your CSV can include these columns (flexible naming):

| Column | Aliases | Required |
|--------|---------|----------|
| full_name | name, Name, FullName | Yes |
| phone | Phone, mobile, Mobile | Yes |
| email | Email | No |
| whatsapp_number | whatsapp, WhatsApp | No |
| organization | Organization, company | No |
| department | Department, dept | No |
| address | Address, street | No |
| city | City | No |
| state | State, province | No |
| postal_code | PostalCode, zip, pincode | No |
| country | Country | No |
| member_id | MemberID, id | No |

## API Endpoints

### Authentication
- `POST /api/auth/login` - Login
- `GET /api/auth/me` - Get current user

### Members
- `GET /api/members` - List members (with pagination & search)
- `POST /api/members` - Create member
- `PUT /api/members/:id` - Update member
- `DELETE /api/members/:id` - Delete member
- `POST /api/members/import` - Import from CSV
- `GET /api/members/export/csv` - Export to CSV

### Campaigns
- `GET /api/campaigns` - List campaigns
- `POST /api/campaigns` - Create campaign
- `PUT /api/campaigns/:id` - Update campaign
- `DELETE /api/campaigns/:id` - Delete campaign
- `POST /api/campaigns/:id/members` - Add members to campaign
- `GET /api/campaigns/:id/members` - Get campaign members

### Broadcasts
- `GET /api/broadcasts` - List broadcasts
- `POST /api/broadcasts` - Create text broadcast
- `POST /api/broadcasts/media` - Create media broadcast
- `POST /api/broadcasts/:id/recipients` - Add recipients
- `POST /api/broadcasts/:id/send` - Send broadcast

### WhatsApp
- `GET /api/whatsapp/status` - Check connection status
- `POST /api/whatsapp/test` - Send test message

## Message Personalization

Use `{name}` in your broadcast messages to personalize with the member's name:

```
Hello {name}, 

We're reaching out to inform you about our upcoming campaign...
```

## Evolution API Setup

1. Install and run Evolution API
2. Create an instance and connect your WhatsApp
3. Get your API key and instance name
4. Configure in `.env` file

## License

MIT
