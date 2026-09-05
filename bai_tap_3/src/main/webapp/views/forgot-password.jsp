<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quên mật khẩu</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <style>
        :root { --blue: #1769e0; --ink: #152238; --muted: #6b778c; --line: #dce3ed; }
        * { box-sizing: border-box; }
        body { min-height: 100vh; margin: 0; color: var(--ink); background: #f4f7fb; font-family: "Trebuchet MS", "Segoe UI", sans-serif; }
        .auth-page { display: grid; grid-template-columns: minmax(0, 1fr) minmax(420px, .86fr); min-height: 100vh; }
        .auth-showcase { position: relative; display: flex; align-items: center; justify-content: center; overflow: hidden; padding: 8vw; background: linear-gradient(145deg, #dcecff, #edf5ff 55%, #fff); }
        .auth-copy { position: relative; z-index: 1; max-width: 460px; }
        .brand-mark { display: inline-flex; align-items: center; justify-content: center; width: 54px; height: 54px; margin-bottom: 28px; border-radius: 16px; color: #fff; background: var(--blue); box-shadow: 0 14px 28px rgba(23, 105, 224, .24); font-size: 1.45rem; font-weight: 800; }
        .auth-copy h1 { max-width: 480px; margin: 0; font-size: clamp(2.8rem, 4.4vw, 4.6rem); line-height: 1.05; letter-spacing: 0; }
        .auth-copy h1 span { color: var(--blue); }
        .auth-copy p { position: relative; z-index: 2; max-width: 390px; margin: 28px 0 0; color: var(--muted); font-size: 1.05rem; line-height: 1.7; }
        .decor-panel { position: absolute; right: -4%; bottom: 4%; width: min(34vw, 340px); height: 190px; border: 12px solid rgba(255,255,255,.78); border-radius: 28px; background: linear-gradient(135deg, #1769e0, #6fb2ff); box-shadow: 0 24px 60px rgba(23,105,224,.22); opacity: .82; transform: rotate(-7deg); }
        .decor-panel::before, .decor-panel::after { content: ""; position: absolute; border-radius: 50%; background: rgba(255,255,255,.8); }
        .decor-panel::before { width: 90px; height: 90px; top: 30px; left: 42px; }
        .decor-panel::after { width: 44px; height: 44px; right: 48px; bottom: 30px; }
        .auth-form-side { display: flex; align-items: center; justify-content: center; padding: 48px 8vw; background: #fff; }
        .auth-form-wrap { width: min(100%, 440px); }
        .auth-form-wrap h2 { margin: 0 0 10px; font-size: 2rem; }
        .auth-intro { margin: 0 0 30px; color: var(--muted); }
        .alert { margin-bottom: 18px; padding: 12px 14px; border: 1px solid #f2b8bd; border-radius: 10px; color: #a51d2d; background: #fff0f1; }
        .field { margin-bottom: 24px; }
        .field label { display: block; margin-bottom: 8px; font-weight: 700; }
        .field input { width: 100%; height: 54px; padding: 0 16px; border: 1px solid var(--line); border-radius: 12px; outline: none; color: var(--ink); font: inherit; }
        .field input:focus { border-color: var(--blue); box-shadow: 0 0 0 4px rgba(23,105,224,.12); }
        .submit { width: 100%; height: 54px; border: 0; border-radius: 12px; color: #fff; background: var(--blue); cursor: pointer; font: inherit; font-weight: 700; box-shadow: 0 10px 20px rgba(23,105,224,.2); }
        .auth-link { display: block; margin-top: 24px; color: var(--muted); text-align: center; text-decoration: none; }
        .auth-link strong { color: var(--blue); }
        @media (max-width: 820px) { .auth-page { grid-template-columns: 1fr; } .auth-showcase { min-height: 390px; padding: 42px 28px; align-items: flex-start; justify-content: flex-start; } .auth-copy h1 { font-size: clamp(2.8rem, 10vw, 4rem); } .decor-panel { right: -85px; bottom: -75px; width: 280px; height: 150px; opacity: .7; } .auth-form-side { padding: 42px 28px 58px; } }
    </style>
</head>
<body>
<main class="auth-page">
    <section class="auth-showcase">
        <div class="auth-copy">
            <div class="brand-mark">B3</div>
            <h1>Khôi phục<br><span>tài khoản.</span></h1>
            <p>Nhập email đã đăng ký để nhận mã OTP và tạo lại mật khẩu của bạn.</p>
        </div>
        <div class="decor-panel" aria-hidden="true"></div>
    </section>
    <section class="auth-form-side">
        <div class="auth-form-wrap">
            <h2>Quên mật khẩu?</h2>
            <p class="auth-intro">Chúng tôi sẽ gửi mã xác nhận đến email của bạn.</p>
            <% if (request.getAttribute("alert") != null) { %><div class="alert"><%= request.getAttribute("alert") %></div><% } %>
            <form action="${pageContext.request.contextPath}/forgot-password" method="post">
                <div class="field"><label for="email">Email</label><input id="email" type="email" name="email" required maxlength="255" placeholder="Nhập email đã đăng ký"></div>
                <button class="submit" type="submit">Gửi mã OTP</button>
            </form>
            <a class="auth-link" href="${pageContext.request.contextPath}/login">Quay lại <strong>đăng nhập</strong></a>
        </div>
    </section>
</main>
</body>
</html>
