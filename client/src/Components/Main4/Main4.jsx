import { useEffect, useState } from 'react'
import style from './Main4.module.scss'
import axios from 'axios'

function Main4()
{
    const [data, setData]= useState([])
    const [startDate, setStartDate] = useState({ day: '01', month: '01', year: '1000' });
    const [endDate, setEndDate] = useState({ day: '28', month: '12', year: '9999' });
    const handleSubmit = () => {
        const date = {
          start: `${startDate.year}-${startDate.month}-${startDate.day}`,
          end: `${endDate.year}-${endDate.month}-${endDate.day}`
        };
    
        axios.post('http://localhost:5000/pz4', date)
          .then(response => {
            setData(response.data); // Установка данных после получения ответа от сервера
          })
          .catch(error => {
            console.error('Ошибка при отправке запроса:', error);
          });
          console.log(data)
      };
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

    return (
        <main>
            
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
          <button className={style.btn} onClick={handleSubmit}>
                Показать
            </button>
            
        <section className={style.section}>
            {
                data.map(item=>(
                    <div className={style.elem}>
                        {
                            Object.keys(item).map(key=>(
                                <div>
                                    <span>{key}: </span>
                                    <span>{item[key]}</span>
                                </div>
                            ))
                        }
                    </div>
                ))
            }
        </section>
        </main>
    )
}
export default Main4