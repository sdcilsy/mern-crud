import {Sequelize} from "sequelize";

const {REACT_APP_DATABASE_HOST} = process.env;

const db = new Sequelize('people','people','people',{
    host: `${REACT_APP_DATABASE_HOST}`,
    dialect: 'mysql'
});

try {
    await db.authenticate();
    console.log('Connection has been established successfully.');
} catch (error) {
    console.error('Unable to connect to the database:', error);
}
  
export default db;