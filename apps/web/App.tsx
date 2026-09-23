import { Link, Route, Routes } from 'react-router-dom';

function Home() {
  return (
    <main>
      <h1>GradLens</h1>
    </main>
  );
}

function App() {
  return (
    <>
      <nav>
        <Link to="/">Home</Link>
      </nav>

      <Routes>
        <Route path="/" element={<Home />} />
      </Routes>
    </>
  );
}

export default App;
