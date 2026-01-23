# Thesis Manager

Laravel application for managing thesis projects.

## Requirements

- PHP >= 8.2
- Composer
- Node.js >= 18.x
- NPM
- MySQL >= 8.0

## Installation

### 1. Clone the Repository

```bash
git clone https://github.com/your-username/thesis-manager.git
cd thesis-manager
```

### 2. Install PHP Dependencies

```bash
composer install
```

### 3. Install Node.js Dependencies

```bash
npm install
```

### 4. Environment Configuration

```bash
cp .env.example .env
```

Update database credentials in `.env`:

```env
DB_DATABASE=thesis_manager
DB_USERNAME=your_username
DB_PASSWORD=your_password
```

### 5. Generate Application Key

```bash
php artisan key:generate
```

### 6. Create Database

Create a new MySQL database named `thesis_manager` (or whatever you specified in your `.env` file).

### 7. Run Database Migrations

```bash
php artisan migrate
```

### 8. Seed the Database

```bash
php artisan db:seed
```

### 9. Create Storage Link

```bash
php artisan storage:link
```

### 10. Build Frontend Assets

```bash
npm run dev
```

### 11. Start Laravel Reverb (Real-time WebSocket Server)

```bash
php artisan reverb:start
```

### 12. Start the Development Server

```bash
php artisan serve
```

Application will be available at `http://127.0.0.1:8000`.
