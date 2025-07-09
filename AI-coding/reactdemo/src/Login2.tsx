import React, { useState } from 'react';
import './Login2.css';

function Login2() {
  const [username, setUsername] = useState('');
  const [adminPwd, setAdminPwd] = useState('');

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    // 管理员登录逻辑
    alert(`管理员登录\n用户名: ${username}\n密码: ${adminPwd}`);
  };

  return (
    <div className="login2-container">
      <form className="login2-form" onSubmit={handleSubmit}>
        <h2>管理员登录</h2>
        <div className="form-group">
          <label htmlFor="username">用户名</label>
          <input
            type="text"
            id="username"
            value={username}
            onChange={(e) => setUsername(e.target.value)}
            required
          />
        </div>
        <div className="form-group">
          <label htmlFor="adminPwd">密码</label>
          <input
            type="password"
            id="adminPwd"
            value={adminPwd}
            onChange={(e) => setAdminPwd(e.target.value)}
            required
          />
        </div>
        <button type="submit" className="login2-button">管理员登录</button>
      </form>
    </div>
  );
}

export default Login2;