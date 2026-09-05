<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Đăng nhập</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <style>
        :root {
            --login-blue: #1769e0;
            --login-ink: #152238;
            --login-muted: #6b778c;
            --login-line: #dce3ed;
        }

        * { box-sizing: border-box; }

        body {
            min-height: 100vh;
            margin: 0;
            color: var(--login-ink);
            background: #f4f7fb;
            font-family: "Trebuchet MS", "Segoe UI", sans-serif;
        }

        .login-page {
            display: grid;
            grid-template-columns: minmax(0, 1fr) minmax(420px, 0.86fr);
            min-height: 100vh;
        }

        .login-showcase {
            position: relative;
            display: flex;
            align-items: flex-start;
            justify-content: center;
            overflow: hidden;
            padding: 13vh 8vw 8vw;
            background: linear-gradient(145deg, #dcecff 0%, #edf5ff 55%, #ffffff 100%);
        }

        .showcase-copy {
            position: relative;
            z-index: 1;
            max-width: 460px;
        }

        .brand-mark {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 54px;
            height: 54px;
            margin-bottom: 28px;
            border-radius: 16px;
            color: #fff;
            background: var(--login-blue);
            box-shadow: 0 14px 28px rgba(23, 105, 224, .24);
            font-size: 1.45rem;
            font-weight: 800;
        }

        .showcase-copy h1 {
            margin: 0;
            font-size: clamp(2.5rem, 5vw, 5.2rem);
            line-height: .98;
            letter-spacing: 0;
        }

        .showcase-copy h1 span { color: var(--login-blue); }

        .showcase-copy p {
            max-width: 360px;
            margin: 26px 0 0;
            color: var(--login-muted);
            font-size: 1.05rem;
            line-height: 1.65;
        }

        .showcase-panel {
            position: absolute;
            right: 9%;
            bottom: 14%;
            width: min(38vw, 380px);
            height: 210px;
            border: 12px solid rgba(255, 255, 255, .78);
            border-radius: 28px;
            background: linear-gradient(135deg, #1769e0, #6fb2ff);
            box-shadow: 0 24px 60px rgba(23, 105, 224, .22);
            transform: rotate(-7deg);
        }

        .showcase-panel::before,
        .showcase-panel::after {
            content: "";
            position: absolute;
            border-radius: 50%;
            background: rgba(255, 255, 255, .8);
        }

        .showcase-panel::before { width: 90px; height: 90px; top: 30px; left: 42px; }
        .showcase-panel::after { width: 44px; height: 44px; right: 48px; bottom: 30px; }

        .login-form-side {
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 48px 8vw;
            background: #fff;
        }

        .login-form-wrap { width: min(100%, 440px); }

        .login-form-wrap h2 {
            margin: 0 0 10px;
            font-size: 2rem;
        }

        .login-form-wrap .intro {
            margin: 0 0 30px;
            color: var(--login-muted);
        }

        .alert {
            margin-bottom: 18px;
            padding: 12px 14px;
            border: 1px solid #f2b8bd;
            border-radius: 10px;
            color: #a51d2d;
            background: #fff0f1;
        }

        .field { margin-bottom: 18px; }
        .field label { display: block; margin-bottom: 8px; font-weight: 700; }
        .field input {
            width: 100%;
            height: 54px;
            padding: 0 16px;
            border: 1px solid var(--login-line);
            border-radius: 12px;
            outline: none;
            color: var(--login-ink);
            font: inherit;
        }
        .field input:focus { border-color: var(--login-blue); box-shadow: 0 0 0 4px rgba(23, 105, 224, .12); }

        .form-options { display: flex; justify-content: space-between; align-items: center; margin: 8px 0 24px; color: var(--login-muted); font-size: .92rem; }
        .remember { display: flex; align-items: center; gap: 8px; }
        .remember input { accent-color: var(--login-blue); }
        a { color: var(--login-blue); text-decoration: none; }
        a:hover { text-decoration: underline; }

        .login-submit {
            width: 100%;
            height: 54px;
            border: 0;
            border-radius: 12px;
            color: #fff;
            background: var(--login-blue);
            cursor: pointer;
            font: inherit;
            font-weight: 700;
            box-shadow: 0 10px 20px rgba(23, 105, 224, .2);
        }

        .register-link { display: block; margin-top: 24px; text-align: center; color: var(--login-muted); }
        .register-link a { font-weight: 700; }

        @media (max-width: 820px) {
            .login-page { grid-template-columns: 1fr; }
            .login-showcase { min-height: 310px; padding: 42px 28px; justify-content: flex-start; }
            .showcase-copy h1 { font-size: 3rem; }
            .showcase-copy p { margin-top: 14px; }
            .showcase-panel { right: -70px; bottom: -35px; width: 280px; height: 150px; }
            .login-form-side { padding: 42px 28px 58px; }
        }
    </style>
</head>
<body>
    <main class="login-page">
        <section class="login-showcase">
            <div class="showcase-copy">
                <div class="brand-mark">B3</div>
                <h1>Mua sắm<br><span>đơn giản hơn</span></h1>
            </div>
            <div class="showcase-panel" aria-hidden="true"></div>
        </section>
        <section class="login-form-side">
            <div class="login-form-wrap">
                <h2>Đăng nhập</h2>
                <c:if test="${alert != null}">
                    <div class="alert">${alert}</div>
                </c:if>
                <form action="${pageContext.request.contextPath}/login" method="post">
                    <div class="field">
                        <label for="username">Tên tài khoản</label>
                        <input type="text" id="username" name="username" required maxlength="50" placeholder="Nhập tên tài khoản">
                    </div>
                    <div class="field">
                        <label for="password">Mật khẩu</label>
                        <input type="password" id="password" name="password" required maxlength="255" placeholder="Nhập mật khẩu">
                    </div>
                    <div class="form-options">
                        <label class="remember"><input type="checkbox" id="remember" name="remember" value="on"> Nhớ đăng nhập</label>
                        <a href="${pageContext.request.contextPath}/forgot-password">Quên mật khẩu?</a>
                    </div>
                    <button class="login-submit" type="submit">Đăng nhập</button>
                </form>
                <div class="register-link">Chưa có tài khoản? <a href="${pageContext.request.contextPath}/register">Tạo tài khoản mới</a></div>
            </div>
        </section>
    </main>
</body>
</html>
