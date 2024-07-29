import axios from 'axios';
import { useEffect, useState } from 'react';
import { Radar, RadarChart, PolarGrid, PolarAngleAxis, PolarRadiusAxis, ResponsiveContainer, Legend, Tooltip } from 'recharts';
import style from './Main2.module.scss'

function Main2()
{
    const [data, setData]=useState([])
    useEffect(() => {
        axios.get('http://localhost:5000/pz2')
          .then(response => {
            const processedData = response.data.map(item => ({
              ...item,
              Общая_сумма_покупок: parseInt(item.Общая_сумма_покупок, 10)
            }));
            setData(processedData);
            
          })
          .catch(error => {
            console.error(error);
          });
      }, []);
    
      console.log(data)
      return(
        <main>
           <div className={style.wrapper}>Общая сумма покупок
                {
                   <table className={style.tableRow}>
                   <thead>
                     <tr>
                       <th className={style.th}>ID покупателя</th>
                       <th className={style.th}>Имя покупателя</th>
                       <th className={style.th}>Общая сумма покупок</th>
                     </tr>
                   </thead>
                   <tbody>
                     {data.map((item, index) => (
                       <tr key={index}>
                         <td className={style.td}>{item.id_покупателя}</td>
                         <td className={style.td1}>{item.Имя}</td>
                         <td className={style.td1}>{item.Общая_сумма_покупок}</td>
                       </tr>
                     ))}
                   </tbody>
                 </table>
                }
              <ResponsiveContainer className='mx-auto' width="47%" height={500}>
                    <RadarChart className={style.radarWrapper} cx="50%" cy="55%" outerRadius="90%" data={data}>
                        <PolarGrid />
                        <PolarAngleAxis dataKey="Имя" />
                        <PolarRadiusAxis domain={[0,1200]} />
                        <Radar dataKey="Общая_сумма_покупок" stroke="#4F46E5" fill="#4F46E5" fillOpacity={0.6} />
                        <Tooltip/>
                        {/* Добавьте другие Radar-элементы, если необходимо */}
                    </RadarChart>
                </ResponsiveContainer>
            </div>
            
        </main>
      )
}
export default Main2