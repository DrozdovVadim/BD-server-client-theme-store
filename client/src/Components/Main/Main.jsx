import axios from 'axios';
import style from './Main.module.scss';
import { useEffect, useState } from 'react';

const Main = () => {
    const [data, setData] = useState([]);
    const [activeItem, setActiveItem] = useState(null);
    const [t, setValue] = useState(1);
    const [formData, setFormData] = useState({});
    const [openAddMenu, setOpenAddMenu]= useState(false)

    const getValue = (e) =>{
        setValue(e.target.value)
    }
    useEffect(() => {
        
        axios.post('http://localhost:5000/data', {
            num: t,
        })
            .then(response => {
                setData([])
                setData(response.data);
            })
            .catch(error => {
                console.error(error);
            });
    }, [t]);


    useEffect(() => {
        if (activeItem) {
            const initialFormData = {};
            initialFormData["value"]=t
            Object.keys(activeItem).forEach(key => {
                initialFormData[key] = activeItem[key];
            });
            setFormData(initialFormData);
        }
    }, [activeItem]);

    const handleChange = (e) => {
        const { name, value } = e.target;
        setFormData(prevState => ({
            ...prevState,
            [name]: value,
            'value': t
        }));
    };
    const addData = () =>
        {
            
            console.log(formData)

        axios.post('http://localhost:5000/add', formData)

         .then(response =>
             {
                setData([])
                 setData(response.data)
             }
         )
         setOpenAddMenu(false)
        }
    const saveData = () =>{
        console.log(formData)
        axios.post('http://localhost:5000/update', formData)

         .then(response =>
             {
                setData([])
                 setData(response.data)
             }
         )
         setActiveItem(null);
    }


    const setupMenu = (item) => {
        setActiveItem(item);
    };
    function addMenu()
    {
        setOpenAddMenu(true);
    }

    const closeMenu = () => {
        setActiveItem(null);
    };
    function closeAddMenu()
    {
        setOpenAddMenu(false)
    }





    function deleteElem(i, e){
        const id= Object.keys(i)[0]
        axios.post('http://localhost:5000/delete', {
            [id]: i[id],
            t: t,
        })
        .then(response =>{
            setData(response.data)
        })
    }
    return (
        <main id='main' className={style.main}>
            <div className={style.selectWrapper}>
                <select className={style.select} name="Таблицы" onChange={getValue} >
                    <option value="1">Товар</option>
                    <option value="2">Поставщик</option>
                    <option value="3">Продавец</option>
                    <option value="4">Покупатель</option>
                    <option value="5">Поставка</option>
                    <option value="6">Продажа</option>
                    <option value="7">Производитель</option>
                    <option value="8">Инфрмация о покупателе</option>
                    <option value="9">Информация о работнике</option>
                    
                </select>
                
            </div>
            <div className={style.count}>Всего {data.length} записей в таблице</div>
            <div>
                <button className={style.addBtn} onClick={addMenu}>Добавить запись</button>
            </div>
            <div  className={style.wrapper}>
                {
                    data.map(item => (
                        <div onClick={(e) => setupMenu(item, e)} className={style.elemCard} >
                            {Object.keys(item).map(key => (
                                <p key={key}>{key}: {item[key]}</p>
                            ))}
                        </div>
                    ))
                }
            </div>
            {
                openAddMenu &&(
                    <div className={style.setupMenu}>
                    <button className={style.closeBtn} onClick={closeAddMenu}>Close</button>
                    <div className={style.inputWrapper} onClick={e => e.stopPropagation()}>
                        {
                            Object.keys(data[0]).slice(1).map(key =>(
                                <div>{key}: <input className={style.elemInput} type="text" name={key}  onChange={handleChange} /></div>
                            ))
                            
                        }
                        
                        
                        
                    </div>
                    <div className={style.btnsWrap}>
                        <button className={style.saveBtn} onClick={addData}>Add</button>
                    </div>
                </div>
                )
            }
            {activeItem && (
                <div className={style.setupMenu}>
                    <button className={style.closeBtn} onClick={closeMenu}>Close</button>
                    <div className={style.inputWrapper} onClick={e => e.stopPropagation()}>
                        {
                            Object.keys(activeItem).slice(1).map(key =>(
                                <div>{key}: <input className={style.elemInput} type="text" name={key} defaultValue={activeItem[key]} onChange={handleChange} /></div>
                            ))
                            
                        }
                        
                        
                        
                    </div>
                    <div className={style.btnsWrap}>
                        <button className={style.saveBtn} onClick={saveData}>Save</button>
                        <button className={style.elemBtn} onClick={(e) => deleteElem(activeItem, e)}>Delete</button>
                    </div>
                </div>
            )}
        </main>
    );
};

export default Main;
