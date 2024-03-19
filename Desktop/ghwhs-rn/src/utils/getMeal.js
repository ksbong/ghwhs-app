import Neis from '@my-school.info/neis-api';
import keys from '../data/neis';

const neis = new Neis({ KEY: keys.apiKey, Type: 'json' });

const getFormattedDate = () => {
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

export default async function getMeal() {
  const res = await neis.getMealInfo({
    ATPT_OFCDC_SC_CODE: keys.ATPT_OFCDC_SC_CODE,
    SD_SCHUL_CODE: keys.SD_SCHUL_CODE,
    MLSV_YMD: getFormattedDate(),
  });

  const [breakFast, lunch, dinner] = [
    res[0]['DDISH_NM']?.replaceAll(' ', '')?.replace(/[0-9]/g, '')?.replaceAll('(', '')?.replaceAll(')', '')?.replaceAll('.', '')?.split('<br/>') || [],
    res[1]['DDISH_NM']?.replaceAll(' ', '')?.replace(/[0-9]/g, '')?.replaceAll('(', '')?.replaceAll(')', '')?.replaceAll('.', '')?.split('<br/>') || [],
    res[2]['DDISH_NM']?.replaceAll(' ', '')?.replace(/[0-9]/g, '')?.replaceAll('(', '')?.replaceAll(')', '')?.replaceAll('.', '')?.split('<br/>') || [],
  ];

  return [breakFast, lunch, dinner];
}
