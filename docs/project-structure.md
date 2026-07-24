# PROJECT CONTEXT & AGENT RULES

## 1. Tổng quan & Tech Stack
- **Mục Đích:** Hệ thống quản lý rạp chiếu phim (Đặt vé, quản lý suất chiếu, phim, người dùng, doanh thu).
- **Architecture:** Monorepo (Gồm Backend Java Spring Boot & Frontend ReactJS).

### Tech Stack
- **Backend (`be-monolith`):** Java 17+, Spring Boot 3.x, Spring Security + JWT, Spring Data JPA, PostgreSQL (hoặc MySQL), MapStruct, Lombok.
- **Frontend (`fe`):** ReactJS, Redux Toolkit (RTK Query/Thunk), React Router v6, Axios, Ant Design v5, Tailwind CSS.

---

## 2. Kiến trúc & Cấu trúc Thư mục

### Backend (`/be-monolith`)
- `config/`: Cấu hình hệ thống (CORS, Swagger, Beans...).
- `controller/`: Tiếp nhận REST API request, không chứa business logic.
- `service/`: Chứa Business Logic (interface + `impl`).
- `repository/`: Spring Data JPA Interfaces.
- `entity/`: Database Entities (JPA Mappings).
- `dto/`: Data Transfer Objects (`request/`, `response/`).
- `mapper/`: MapStruct mappers chuyển đổi giữa Entity <-> DTO.
- `exception/`: Custom Exception Classes & GlobalExceptionHandler (`@RestControllerAdvice`).
- `security/` & `jwt/`: Spring Security, JWT Filter & Token Provider.
- `validation/`: Custom Annotation Validations.
- `aspect/`: AOP cho Logging, Transaction, Audit.

### Frontend (`/fe`)
- `src/features/`: Chia theo Module/Role (`admin/`, `auth/`, `staff/`, `user/`, `super-admin/`).
- `src/layout/`: Main Layouts (Sidebar, Header, Footer theo Role).
- `src/api/`: Base Axios Instance, API Endpoints list.
- `src/store/`: Redux Toolkit Store configuration & Slices.
- `src/router/`: Config tuyến đường (Protected Routes theo Role).
- `src/hooks/` & `src/utils/`: Custom hooks & helper functions dùng chung.

---

## 3. Quy chuẩn Đặt tên (Naming Conventions)
- **Class / Interface / React Component:** `PascalCase` (VD: `BookingService`, `MovieCard.jsx`).
- **Function / Method / Variable / Hook:** `camelCase` (VD: `calculateTotalPrice()`, `useAuth()`).
- **Constant:** `UPPER_SNAKE_CASE` (VD: `MAX_SEATING_CAPACITY`, `API_BASE_URL`).
- **Database Tables / Columns:** `snake_case` (VD: `movie_schedules`, `created_at`).
- **RESTful API Endpoint:** `kebab-case`, danh từ số nhiều (VD: `/api/v1/movie-schedules`, `/api/v1/booking-tickets`).

---

## 4. Quy chuẩn Viết Code & Bắt lỗi

### General Rules (Nguyên tắc chung)
- Code rõ ràng, tự giải thích (Clean Code), viết comment Javadoc/JSDoc cho logic phức tạp.
- Luôn validate dữ liệu đầu vào cả ở FE (Form UI) và BE (DTO Validation `@Valid`).

### Backend (Java / Spring Boot)
- **Architecture Pattern:** Controller $\rightarrow$ Service $\rightarrow$ Repository.
- **DTO Binding:** Tuyệt đối không trả về `Entity` trực tiếp qua API, bắt buộc qua `DTO`.
- **Exception Handling:** Mọi lỗi Business Logic phải throw Custom Exception (VD: `ResourceNotFoundException`, `BadRequestException`).
- **Response Format:** Chuẩn hóa Response JSON trả về Client:
  ```json
  {
    "status": 200,
    "message": "Success",
    "data": { ... }
  }