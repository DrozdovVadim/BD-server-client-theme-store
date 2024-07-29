import { useEffect, useState } from 'react'
import style from './Main3.module.scss'
import axios from 'axios';

import { saveAs } from 'file-saver';

function Main3(){
    const [startDate, setStartDate] = useState({ day: '01', month: '01', year: '1000' });
    const [endDate, setEndDate] = useState({ day: '28', month: '12', year: '9999' });
    const [data, setData]=useState([])

    const handleDownload = ()=>{
        const date = {
            start: `${startDate.year}-${startDate.month}-${startDate.day}`,
            end: `${endDate.year}-${endDate.month}-${endDate.day}`
          };
          axios.post('http://localhost:5000/download1', date, { responseType: 'blob' })
        .then(response =>{
            const blob= new Blob([response.data], {type: 'text/txt'})
            saveAs(blob, 'data.txt'); 

        }).catch(error => {
            console.error('Ошибка при отправке запроса:', error);
          });
    }
    const handleSubmit = () => {
        const date = {
          start: `${startDate.year}-${startDate.month}-${startDate.day}`,
          end: `${endDate.year}-${endDate.month}-${endDate.day}`
        };
    
        axios.post('http://localhost:5000/pz3', date)
          .then(response => {
            setData(response.data); // Установка данных после получения ответа от сервера
          })
          .catch(error => {
            console.error('Ошибка при отправке запроса:', error);
          });
      };
    
      useEffect(() => {
        console.log(data); // Логируем данные после обновления state
      }, [data]); // Зависимость: э
    const handleInputChange = (event, dateType, field) => {
        const value = event.target.value;
        if (dateType === 'start') {
          setStartDate({
            ...startDate,
            [field]: value
          });
        } else {
          setEndDate({
            ...endDate,
            [field]: value
          });
        }
      };
      
      
    return(
        <main>
        <p className={style.title}>Введите две даты чтобы получить запрос</p>
        <div className={style.dateWrapper}>
          <div className={style.inputWrapper}>
            С:
            <input
              maxLength={2}
              className={style.input}
              type="text"
              placeholder='dd'
              onChange={(e) => handleInputChange(e, 'start', 'day')}
            />
            <input
              maxLength={2}
              className={style.input}
              type="text"
              placeholder='mm'
              onChange={(e) => handleInputChange(e, 'start', 'month')}
            />
            <input
              maxLength={4}
              className={style.input}
              type="text"
              placeholder='yyyy'
              onChange={(e) => handleInputChange(e, 'start', 'year')}
            />
          </div>
          <div className={style.inputWrapper}>
            По:
            <input
              maxLength={2}
              className={style.input}
              type="text"
              placeholder='dd'
              onChange={(e) => handleInputChange(e, 'end', 'day')}
            />
            <input
              maxLength={2}
              className={style.input}
              type="text"
              placeholder='mm'
              onChange={(e) => handleInputChange(e, 'end', 'month')}
            />
            <input
              maxLength={4}
              className={style.input}
              type="text"
              placeholder='yyyy'
              onChange={(e) => handleInputChange(e, 'end', 'year')}
            />
          </div>
        </div>
        <div className={style.btnContainer}>
            
            <button className={style.btn} onClick={handleDownload}>
                Скачать отчет
            </button>
            <button className={style.btn} onClick={handleSubmit}>
                Показать
            </button>
        </div>
        
        <div className={style.elemContainer}>
            {
                data.map(item =>
                    (
                        <div className={style.elem}>
                        {    Object.keys(item).map(key=> (
                                <div className={style.elemContant} >
                                    <span className={style.elemTitle}>{key}: </span>
                                    <span className={style.elemText}>{item[key]}</span>
                                </div>
                                
                            ))}
                        </div>
                    )
                )
            }
        </div>
      </main>
      
    )
}
export default Main3