import style from "./Header.module.scss";
import { Link } from 'react-router-dom';

const Header = () => {
    return (
        <header className={style.wrapper}>
            <ul className={style.ul}>
                <Link to="/">
                    <li className={style.li}>Просмотр таблиц</li>
                </Link>
                <Link to="/pz1">
                    <li className={style.li}>1-ая прикладная</li>
                </Link>
                <Link to="/pz2">
                    <li className={style.li}>2-ая прикладная</li>
                </Link>
                <Link to="/pz3">
                    <li className={style.li}>3-яя прикладная</li>
                </Link>
                <Link to="/pz4">
                    <li className={style.li}>4-ая прикладная</li>
                </Link>
            </ul>
        </header>
    )
}
export default Header;