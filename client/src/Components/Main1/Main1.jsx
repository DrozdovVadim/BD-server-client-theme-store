import axios from 'axios';
import { useEffect, useState } from 'react';
import { PieChart, Pie, Legend, Cell, ResponsiveContainer, BarChart, Bar, XAxis, YAxis, Tooltip, CartesianGrid } from 'recharts';
import style from './Main1.module.scss'

function Main1()
{
  const COLORS = ['#0088FE', '#00C49F', '#FFBB28', '#FF8042', '#FF4560', '#775DD0', '#546E7A', '#26a69a', '#D4E157'];
    const [data, setData]= useState([])
    
    useEffect(() => {
      axios.get('http://localhost:5000/pz1')
        .then(response => {
          const processedData = response.data.map(item => ({
            ...item,
            Количество_покупок: parseInt(item.Количество_покупок, 10)
          }));
          setData(processedData);
        })
        .catch(error => {
          console.error(error);
        });
    }, []);
    return (
        <main>
            <div className={style.wrapper}>Демографический анализ покупателей
                {
                   <table className={style.tableRow}>
                   <thead>
                     <tr>
                       <th className={style.th}>Возрастная группа</th>
                       <th className={style.th}>Количество покупок</th>
                     </tr>
                   </thead>
                   <tbody>
                     {data.map((item, index) => (
                       <tr key={index}>
                         <td className={style.td}>{item.Возрастная_группа}</td>
                         <td className={style.td1}>{item.Количество_покупок}</td>
                       </tr>
                     ))}
                   </tbody>
                 </table>
                }
                <div className={style.diagrammcontainer}>
                  <ResponsiveContainer  width="47%" height={400}>
                    <PieChart className={style.pieWrapper}>
                      <Pie 
                        data={data}
                        dataKey="Количество_покупок" 
                        nameKey="Возрастная_группа" 
                        outerRadius="80%" 
                        innerRadius="30%"
                        label
                        animationBegin={0}       
                        animationDuration={1500} 
                        animationEasing="ease-out" 
                      >
                        {
                          data.map((entry, index) => (
                            <Cell key={`cell-${index}`} fill={COLORS[index % COLORS.length]} />
                          ))
                        }
                      </Pie>
                      <Legend 
                        layout="horizontal" 
                        align="center" 
                        verticalAlign="bottom" 
                      />

                    </PieChart>
                  </ResponsiveContainer>
                <ResponsiveContainer width="47%" height={400}>
                  <BarChart className={style.pieWrapper} data={data}>
                    <CartesianGrid strokeDasharray="3 3" />
                    <XAxis dataKey="Возрастная_группа" />
                    <YAxis />
                    <Tooltip />
                    <Legend />
                    <Bar 
                      dataKey="Количество_покупок" 
                      fill="#8884d8"
                      animationBegin={0}       
                      animationDuration={1500} 
                      animationEasing="ease-out" 
                    >
            {
              data.map((entry, index) => (
                <Cell key={`cell-${index}`} fill={COLORS[index % COLORS.length]} />
              ))
            }
          </Bar>
        </BarChart>
      </ResponsiveContainer>
      </div>
            </div>
            
        </main>
    )
}
export default Main1;