const express = require('express');
const app= express();
const cors= require('cors');
const PORT=5000;
const {Pool} = require('pg')
const path = require('path');
const fs = require('fs');


const pool= new Pool({
    user: 'postgres',
    password: '2819',
    host: 'localhost',
    database: 'courseStore',
    port: 3001,
})
const tables = ["Товар", "Поставщик", "Продавец", "Покупатель", "Поставка", "Продажа", "Производитель", "Характеристики_покупателя", "Информация_о_работнике"]
const primaryKeys=['id_товара','id_поставщика','id_продавца', 'id_покупателя','id_поставки', 'id_продажи', 'id_производителя', 'id_покупателя', 'id_работника']
app.use(cors());
app.use(express.urlencoded({ extended: true }));
app.use(express.json({ extended: true }));


app.post('/delete', async (req, res) =>{
  const tableName = tables[req.body.t-1]; //имя таблицы из массива таблиц
  const id = req.body[Object.keys(req.body)[0]]; //id записи таблицы которую следует удалить
  try{
  
    const deleteQuery = `DELETE FROM ${tableName} WHERE ${Object.keys(req.body)[0]} = $1`;
    console.log(deleteQuery)
    
    await pool.query(deleteQuery, [id]);
    const result = await pool.query(`SELECT * FROM ${tableName} ORDER BY ${primaryKeys[req.body.t-1]}`);
    res.json(result.rows);
  } catch(err){
    console.log(err);
    res.status(500).send('Ошибка сервера');
  } 
})

app.post('/add', async (req,res) =>{
  const table= req.body.value-1
  try {
    if (table == 0) {
      const insertQuery = `
        INSERT INTO Товар (Название, Вид, id_производителя, id_поставщика, Цена)
        VALUES ($1, $2, $3, $4, $5)
        RETURNING *;
      `;
      
      const selectQuery = 'SELECT * FROM Товар ORDER BY id_товара';
      
      const values = [
        req.body.Название,
        req.body.Вид,
        req.body.id_производителя,
        req.body.id_поставщика,
        req.body.Цена
      ];
  
      await pool.query(insertQuery, values);
      const selectResult = await pool.query(selectQuery);
      
      res.json(selectResult.rows);
    } else if (table == 1) {
      const insertQuery = `
        INSERT INTO Поставщик (Название_поставщика)
        VALUES ($1)
        RETURNING *;
      `;
  
      const selectQuery = 'SELECT * FROM Поставщик ORDER BY id_поставщика';
      
      const values = [
        req.body.Название_поставщика
      ];
  
      await pool.query(insertQuery, values);
      const selectResult = await pool.query(selectQuery);
      
      res.json(selectResult.rows);
    } else if (table == 2) {
      const insertQuery = `
        INSERT INTO Продавец (Имя)
        VALUES ($1)
        RETURNING *;
      `;
  
      const selectQuery = 'SELECT * FROM Продавец ORDER BY id_продавца';
      
      const values = [
        req.body.Имя
      ];
  
      await pool.query(insertQuery, values);
      const selectResult = await pool.query(selectQuery);
      
      res.json(selectResult.rows);
    } else if (table == 3) {
      const insertQuery = `
        INSERT INTO Покупатель (Имя, Возраст, Пол)
        VALUES ($1, $2, $3)
        RETURNING *;
      `;
  
      const selectQuery = 'SELECT * FROM Покупатель ORDER BY id_покупателя';
      
      const values = [
        req.body.Имя,
        req.body.Возраст,
        req.body.Пол
      ];
  
      await pool.query(insertQuery, values);
      const selectResult = await pool.query(selectQuery);
      
      res.json(selectResult.rows);
    } else if (table == 4) {
      const insertQuery = `
        INSERT INTO Поставка (id_товара, Количество, Дата_поставки)
        VALUES ($1, $2, $3)
        RETURNING *;
      `;
  
      const selectQuery = 'SELECT * FROM Поставка ORDER BY id_поставки';
      
      const values = [
        req.body.id_товара,
        req.body.Количество,
        req.body.Дата_поставки
      ];
  
      await pool.query(insertQuery, values);
      const selectResult = await pool.query(selectQuery);
      
      res.json(selectResult.rows);
    } else if (table == 5) {
      const insertQuery = `
        INSERT INTO Продажа (id_товара, id_продавца, id_покупателя, Дата_продажи)
        VALUES ($1, $2, $3, $4)
        RETURNING *;
      `;
  
      const selectQuery = 'SELECT * FROM Продажа ORDER BY id_продажи';
      
      const values = [
        req.body.id_товара,
        req.body.id_продавца,
        req.body.id_покупателя,
        req.body.Дата_продажи
      ];
  
      await pool.query(insertQuery, values);
      const selectResult = await pool.query(selectQuery);
      
      res.json(selectResult.rows);
    } else if (table == 6) {
      const insertQuery = `
        INSERT INTO Производитель (Название_производителя)
        VALUES ($1)
        RETURNING *;
      `;
  
      const selectQuery = 'SELECT * FROM Производитель ORDER BY id_производителя';
      
      const values = [
        req.body.Название_производителя
      ];
  
      await pool.query(insertQuery, values);
      const selectResult = await pool.query(selectQuery);
      
      res.json(selectResult.rows);
    }
    else if (table == 7) {
      const insertQuery = `
        INSERT INTO Характеристики_покупателя (Возрастная_группа, Пол)
      VALUES ($1, $2)
      RETURNING *;
    `;

    const selectQuery = 'SELECT * FROM Характеристики_покупателя ORDER BY id_покупателя';
    
    const values = [
      req.body.Возрастная_группа,
      req.body.Пол
    ];

    await pool.query(insertQuery, values);
    const selectResult = await pool.query(selectQuery);
    
    res.json(selectResult.rows);
  } else if (table == 8) {
    const insertQuery = `
      INSERT INTO Информация_о_работнике (Количество_продаж, Количество_часов, Заработная_плата, Дата)
      VALUES ($1, $2, $3, $4)
      RETURNING *;
    `;

    const selectQuery = 'SELECT * FROM Информация_о_работнике ORDER BY id_работника';
    
    const values = [
      req.body.Количество_продаж,
      req.body.Количество_часов,
      req.body.Заработная_плата,
      req.body.Дата
    ];

    await pool.query(insertQuery, values);
    const selectResult = await pool.query(selectQuery);
    
    res.json(selectResult.rows);
  } else {
    res.status(400).json({ error: 'Invalid table number' });
  }
} catch (err) {
  console.error(err);
  res.status(500).json({ error: 'Database error' });
}
})


app.post('/data', async (req, res) => {
    try {
      const result = await pool.query(`Select * from ${tables[req.body.num-1]} ORDER BY ${primaryKeys[req.body.num-1]}`);
      res.json(result.rows);
    } catch (err) {
      console.error(err);
      res.status(500).send('Ошибка сервера');
    }
  });



app.post('/update', async(req,res) =>{
  const table=req.body.value-1
  
  try
  {
    if (table == 0) {
      const updateQuery = `
        UPDATE Товар
        SET Название = $1,
            Вид = $2,
            id_производителя = $3,
            id_поставщика = $4,
            Цена = $5
        WHERE id_товара = $6;
      `;
      const selectQuery = 'SELECT * FROM Товар ORDER BY id_товара';
      const values = [
        req.body.Название,
        req.body.Вид,
        req.body.id_производителя,
        req.body.id_поставщика,
        req.body.Цена,
        req.body.id_товара
      ];
      await pool.query(updateQuery, values);
    

    const result = await pool.query(selectQuery);
    

    res.json(result.rows);
    }    
    else if (table == 1) {
      const updateQuery = `
        UPDATE Поставщик
        SET Название_поставщика = $1
        WHERE id_поставщика = $2;
      `;
      
      const selectQuery = 'SELECT * FROM Поставщик ORDER BY id_поставщика';
      
      const values = [
        req.body.Название_поставщика,
        req.body.id_поставщика
      ];
      await pool.query(updateQuery, values);
    
    // Выполнение запроса на получение всех данных из таблицы с сортировкой по id_поставщика
    const result = await pool.query(selectQuery);
    
    // Возврат всех данных из таблицы
    res.json(result.rows);
    }
    else if (table==2){
      const updateQuery = `
        UPDATE Продавец
        SET Имя = $1
        WHERE id_продавца = $2;
      `;
      
      const selectQuery = 'SELECT * FROM Продавец ORDER BY id_продавца';
      
      const values = [
        req.body.Имя,
        req.body.id_продавца
      ];
      await pool.query(updateQuery, values);
    
      // Выполнение запроса на получение всех данных из таблицы с сортировкой по id_продавца
      const result = await pool.query(selectQuery);
      
      // Возврат всех данных из таблицы
      res.json(result.rows);
    }
    else if (table==3){
          const updateQuery = `
        UPDATE Покупатель
        SET Имя = $1,
            Возраст = $2,
            Пол = $3
        WHERE id_покупателя = $4;
      `;
      
      const selectQuery = 'SELECT * FROM Покупатель ORDER BY id_покупателя';
      
      const values = [
        req.body.Имя,
        req.body.Возраст,
        req.body.Пол,
        req.body.id_покупателя
      ];
      await pool.query(updateQuery, values);
    
    // Выполнение запроса на получение всех данных из таблицы с сортировкой по id_покупателя
      const result = await pool.query(selectQuery);
    
    // Возврат всех данных из таблицы
      res.json(result.rows);
    }
    else if (table==4){
      const updateQuery = `
        UPDATE Поставка
        SET id_товара = $1,
            Количество = $2,
            Дата_поставки = $3
        WHERE id_поставки = $4;
      `;
      
      const selectQuery = 'SELECT * FROM Поставка ORDER BY id_поставки';
      
      const values = [
        req.body.id_товара,
        req.body.Количество,
        req.body.Дата_поставки,
        req.body.id_поставки
      ];
      await pool.query(updateQuery, values);
    
    // Выполнение запроса на получение всех данных из таблицы с сортировкой по id_поставки
      const result = await pool.query(selectQuery);
      
      // Возврат всех данных из таблицы
      res.json(result.rows);
    }
    else if (table==5){
      const updateQuery = `
        UPDATE Продажа
        SET id_товара = $1,
            id_продавца = $2,
            id_покупателя = $3,
            Дата_продажи = $4
        WHERE id_продажи = $5;
      `;
      
      const selectQuery = 'SELECT * FROM Продажа ORDER BY id_продажи';
      
      const values = [
        req.body.id_товара,
        req.body.id_продавца,
        req.body.id_покупателя,
        req.body.Дата_продажи,
        req.body.id_продажи
      ];
      await pool.query(updateQuery, values);
    
      // Выполнение запроса на получение всех данных из таблицы с сортировкой по id_продажи
      const result = await pool.query(selectQuery);
      
      // Возврат всех данных из таблицы
      res.json(result.rows);
    }
    else if (table==6){
      const updateQuery = `
        UPDATE Производитель
        SET Название_производителя = $1
        WHERE id_производителя = $2;
      `;
      
      const selectQuery = 'SELECT * FROM Производитель ORDER BY id_производителя';
      
      const values = [
        req.body.Название_производителя,
        req.body.id_производителя
      ];
      await pool.query(updateQuery, values);
    
    // Выполнение запроса на получение всех данных из таблицы с сортировкой по id_производителя
      const result = await pool.query(selectQuery);
      
      // Возврат всех данных из таблицы
      res.json(result.rows);
    }
    else if (table==7){
      const updateQuery = `
        UPDATE Характеристики_покупателя
        SET Возрастная_группа = $1,
            Пол = $2
        WHERE id_покупателя = $3;
      `;
      
      const selectQuery = 'SELECT * FROM Характеристики_покупателя ORDER BY id_покупателя';
      
      const values = [
        req.body.Возрастная_группа,
        req.body.Пол,
        req.body.id_покупателя
      ];
      await pool.query(updateQuery, values);
    
    // Выполнение запроса на получение всех данных из таблицы с сортировкой по id_покупателя
      const result = await pool.query(selectQuery);
      
      // Возврат всех данных из таблицы
      res.json(result.rows);
    }
    else if (table==8){
      const updateQuery = `
      UPDATE Информация_о_работнике
      SET Количество_продаж = $1,
          Количество_часов = $2,
          Заработная_плата = $3,
          Дата = $4
      WHERE id_работника = $5;
    `;
    
    const selectQuery = 'SELECT * FROM Информация_о_работнике ORDER BY id_работника';
    
    const values = [
      req.body.Количество_продаж,
      req.body.Количество_часов,
      req.body.Заработная_плата,
      req.body.Дата,
      req.body.id_работника
    ];
    await pool.query(updateQuery, values);
    
    // Выполнение запроса на получение всех данных из таблицы с сортировкой по id_работника
    const result = await pool.query(selectQuery);
    
    // Возврат всех данных из таблицы
    res.json(result.rows);
    }
    
  } catch (err)
  {
    console.log(err)
    res.status(500).send('Ошибка сервера');
  }
});

app.get('/pz1', async(req, res)=>{
  try{
    const query = `
      SELECT
        Характеристики_покупателя.Возрастная_группа,
        COUNT(Продажа.id_продажи) AS Количество_покупок
      FROM
        Продажа
      JOIN
        Характеристики_покупателя ON Продажа.id_покупателя = Характеристики_покупателя.id_покупателя
      GROUP BY
        Характеристики_покупателя.Возрастная_группа
      ORDER BY
        Количество_покупок DESC;
    `;
    const result = await pool.query(query)
    res.json(result.rows)
    
  } catch(err){
    console.log(err)
  }
})
app.get('/pz2', async(req,res)=>{
  try{
    const query = `
      SELECT
        Покупатель.id_покупателя,
        Покупатель.Имя,
        SUM(Товар.Цена) AS Общая_сумма_покупок
      FROM
        Продажа
      JOIN
        Покупатель ON Продажа.id_покупателя = Покупатель.id_покупателя
      JOIN
        Товар ON Продажа.id_товара = Товар.id_товара
      GROUP BY
        Покупатель.id_покупателя, Покупатель.Имя;
    `;
    const result= await pool.query(query)
    res.json(result.rows)
  }catch(err){
    console.log(err)
  }
})

app.post('/pz3', async(req,res)=>{
  const date1 = req.body.start;
  const date2 = req.body.end;


  try {
    const query = `
      SELECT
    Продажа.Дата_продажи,
    Товар.Название AS Название_товара,
    Товар.Цена AS Цена_товара,
    Продавец.Имя AS Имя_продавца,
    Покупатель.Имя AS Имя_покупателя
FROM
    Продажа
JOIN
    Товар ON Продажа.id_товара = Товар.id_товара
JOIN
    Продавец ON Продажа.id_продавца = Продавец.id_продавца
JOIN
    Покупатель ON Продажа.id_покупателя = Покупатель.id_покупателя
WHERE
    Продажа.Дата_продажи BETWEEN $1 AND $2;

    `;
    const result = await pool.query(query, [date1, date2]);
    console.log(result.rows)
    res.json(result.rows);
  }catch(err){
      console.error(err)
  }
})

app.post('/download1', async (req, res) => {
  const date1 = req.body.start;
  const date2 = req.body.end;
  console.log('date1:', date1);
  console.log('date2:', date2);
  const query = `
  SELECT
    Продажа.Дата_продажи,
    Товар.Название AS Название_товара,
    Товар.Цена AS Цена_товара,
    Продавец.Имя AS Имя_продавца,
    Покупатель.Имя AS Имя_покупателя
    FROM
    Продажа
    JOIN
    Товар ON Продажа.id_товара = Товар.id_товара
    JOIN
    Продавец ON Продажа.id_продавца = Продавец.id_продавца
    JOIN
    Покупатель ON Продажа.id_покупателя = Покупатель.id_покупателя
    WHERE
    Продажа.Дата_продажи BETWEEN $1 AND $2;

    `;
    try {
      const result = await pool.query(query, [date1, date2]);
      if (result.rows.length === 0) {
        return res.status(404).send('Данные не найдены');
      }
  
      const filePath = path.join(__dirname, 'data.txt');
  
      // Создание заголовка текстового файла
      const headers = 'Дата_продажи, Название_товара, Цена_товара, Имя_продавца, Имя_покупателя\n';
  
      // Создание контента текстового файла
      const fileContent = result.rows.map(row => Object.values(row).map(value => `"${value}"`).join(', ')).join('\n');
  
      // Запись заголовка и контента в текстовый файл
      fs.writeFileSync(filePath, headers + fileContent, { encoding: 'utf8' });
  
      // Отправка файла клиенту
      res.download(filePath, 'data.txt', (err) => {
        if (err) {
          console.error(err);
        }
  
        // Удаление файла после отправки
        fs.unlinkSync(filePath);
      });
    } catch (err) {
    console.error(err);
    res.status(500).send('Внутренняя ошибка сервера');
  }
});

app.post('/pz4', async(req,res)=>{
  const date1=req.body.start
  const date2=req.body.end
  const query=`
    SELECT
    Товар.Название,
    Поставщик.Название_поставщика,
    Поставка.Количество,
    Поставка.Дата_поставки
FROM
    Поставка
JOIN
    Товар ON Поставка.id_товара = Товар.id_товара
JOIN
    Поставщик ON Товар.id_поставщика = Поставщик.id_поставщика
WHERE
    Поставка.Дата_поставки BETWEEN $1 AND $2 
ORDER BY
    Поставка.Дата_поставки;

`
try{
  const result=await pool.query(query,[date1, date2])
  console.log(result.rows)
  res.json(result.rows)
}catch(err){
  console.log(err)
}
})

app.listen(PORT, ()=> {
    console.log(`Сервер запущен на порту ${PORT}`);
});