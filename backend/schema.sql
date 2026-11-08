-- 1. Department
CREATE TABLE
    IF NOT EXISTS department (
        id SERIAL PRIMARY KEY,
        name VARCHAR(100) UNIQUE NOT NULL
    );

-- 2. Course
CREATE TABLE
    IF NOT EXISTS course (
        id SERIAL PRIMARY KEY,
        course_code VARCHAR(10) UNIQUE NOT NULL,
        title VARCHAR(100) NOT NULL,
        department_id INT NOT NULL REFERENCES department (id)
    );

-- 3. Student
CREATE TABLE
    IF NOT EXISTS student (
        id SERIAL PRIMARY KEY,
        full_name VARCHAR(100) NOT NULL,
        id_number VARCHAR(20) UNIQUE NOT NULL,
        registration_number VARCHAR(20) UNIQUE NOT NULL,
        gender VARCHAR(20) NOT NULL DEFAULT 'prefer_not_to_say' CHECK (gender IN ('male', 'female', 'prefer_not_to_say')),
        enrollment_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        course_id INT NOT NULL REFERENCES course (id),
        payment_status BOOLEAN NOT NULL DEFAULT FALSE
    );

-- 4. Book
CREATE TABLE
    IF NOT EXISTS book (
        id SERIAL PRIMARY KEY,
        isbn VARCHAR(20) NOT NULL,
        title VARCHAR(100) NOT NULL,
        author VARCHAR(100) NOT NULL
    );

-- 5. Book Loan
CREATE TABLE
    IF NOT EXISTS book_loan (
        id SERIAL PRIMARY KEY,
        book_id INT NOT NULL REFERENCES book (id),
        student_id INT NOT NULL REFERENCES student (id),
        date_borrowed TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        date_returned TIMESTAMP
    );

-- 6. Hostel
CREATE TABLE
    IF NOT EXISTS hostel (
        id SERIAL PRIMARY KEY,
        name VARCHAR(100) NOT NULL,
        location VARCHAR(100) NOT NULL
    );

-- 7. Room
CREATE TABLE
    IF NOT EXISTS room (
        id SERIAL PRIMARY KEY,
        hostel_id INT NOT NULL REFERENCES hostel (id),
        room_no VARCHAR(20) NOT NULL,
        room_type VARCHAR(100) CHECK (
            room_type IN ('bedsitter', '1_bedroom', 'single_room')
        ),
        shareable BOOLEAN DEFAULT TRUE,
        UNIQUE (hostel_id, room_no)
    );

-- 8. Room Allocation
CREATE TABLE
    IF NOT EXISTS room_allocation (
        id SERIAL PRIMARY KEY,
        student_id INT NOT NULL UNIQUE REFERENCES student (id),
        room_id INT NOT NULL REFERENCES room (id),
        allocated_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    );

-- 9. Transactions
CREATE TABLE
    IF NOT EXISTS transaction (
        id SERIAL PRIMARY KEY,
        student_id INT NOT NULL REFERENCES student (id),
        amount DECIMAL(10, 2) NOT NULL,
        transaction_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        transaction_status VARCHAR(20) NOT NULL DEFAULT 'pending' CHECK (transction_status IN ('pending', 'completed', 'failed'))
    );