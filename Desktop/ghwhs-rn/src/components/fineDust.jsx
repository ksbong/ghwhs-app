import React, { useState, useEffect } from 'react';
import { View, Text } from 'react-native';
import { ref, get } from 'firebase/database';
import { db } from '../data/firebase';

export default function FineDust() {
  const [fineDust, setFineDust] = useState(0);

  useEffect(() => {
    const dbRef = ref(db);
    get(dbRef)
      .then((snapshot) => {
        if (snapshot.exists()) {
          console.log(snapshot.val());
          setFineDust(snapshot.val()['미세먼지']);
        } else {
          console.log('No data available');
        }
      })
      .catch((error) => {
        console.log(error);
      });
  });

  return (
    <View>
      <Text>미세먼지: {fineDust}</Text>
    </View>
  );
}
