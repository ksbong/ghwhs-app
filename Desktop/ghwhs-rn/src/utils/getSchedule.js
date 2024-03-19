import Neis from '@my-school.info/neis-api';
import keys from '../data/neis';
import { getFormattedToday, getFormattedLastDay } from '../data/date';

const neis = new Neis({ KEY: keys.apiKey, Type: 'json' });



neis.getSchedule({
    ATPT_OFCDC_SC_CODE: keys.ATPT_OFCDC_SC_CODE,
    SD_SCHUL_CODE: keys.SD_SCHUL_CODE,
    AA_FROM_YMD: getFormattedToday(),
    AA_TO_YMD: getFormattedLastDay()
}).then((res) => {
    console.log(res)
})