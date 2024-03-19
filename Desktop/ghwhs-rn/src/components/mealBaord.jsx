import { ActivityIndicator, FlatList, StyleSheet, Text, View } from 'react-native';
import { useEffect, useState } from 'react';

import getMeal from '../utils/getMeal';

export default function MealBoard() {
  const [check, setCheck] = useState(false);
  const [meal, setMeal] = useState([['조식'], ['중식'], ['석식']]);



  useEffect(() => {
    async function checkData() {
      const data = await getMeal();

      setMeal(data);
      setCheck(true);
    }
    checkData();

    // for (var i = 0; i < meal.length; i++) {
    //   for (var j = 0; i < meal[i].length; j++) {
    //     var temp = '';
    //     temp += meal[i][j].toString();

    //     setBreakFast(temp);
    //     setLunch(temp);
    //     setDinner(temp);
    //   }
    // }
  });

  return check ? (
      <View style={styles.mealBoard}>
        <Text>조식</Text>
        <FlatList data={meal[0]} renderItem={({ item }) => <Text>{item}</Text>} />
        <Text>중식</Text>
        <FlatList data={meal[1]} renderItem={({ item }) => <Text>{item}</Text>} />
        <Text>석식</Text>
      <FlatList data={meal[2]} renderItem={({ item }) => <Text>{item}</Text>} />
      </View>
  ) : (
    <View style={styles.loading}>
        <Text>로딩중인겨~</Text>
        <ActivityIndicator size="large" color="#FC8EAC" />
    </View>
  );
}

const styles = StyleSheet.create({
  mealBoard: {
    flex: 1,
    flexDirection: 'column',
    justifyContent: 'center',
    alignItems: 'center',
  },
  loading: {
    flex: 1,
    flexDirection: 'column',
    justifyContent: 'center',
    alignItems: 'center'
  }
});
