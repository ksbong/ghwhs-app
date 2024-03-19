const getFormattedToday = () => {
    const date = new Date();
    if (date.getMonth() + 1 < 10 && date.getDate() < 10) {
      return `${date.getFullYear()}0${date.getMonth() + 1}0${date.getDate()}`;
    } else if (date.getMonth() + 1 < 10 && date.getDate() >= 10) {
      return `${date.getFullYear()}0${date.getMonth() + 1}${date.getDate()}`;
    } else if (date.getMonth() + 1 >= 10 && date.getDate() < 10) {
      return `${date.getFullYear()}${date.getMonth() + 1}0${date.getDate()}`;
    } else {
      return `${date.getFullYear()}${date.getMonth() + 1}${date.getDate()}`;
    }
  };
  
  const getFormattedLastDay = () => {
    const date = new Date();
    const lastDay = new Date(date.getFullYear(), date.getMonth() + 1, 0).getDate();
  
    if (date.getMonth() + 1 < 10 && date.getDate() >= 10) {
      return `${date.getFullYear()}0${date.getMonth() + 1}${lastDay}`;
    } else if (date.getMonth() + 1 >= 10 && date.getDate() < 10) {
      return `${date.getFullYear()}${date.getMonth() + 1}${lastDay}`;
    }
  };
  
  export { getFormattedToday, getFormattedLastDay };
  