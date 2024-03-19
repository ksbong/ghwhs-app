import React from 'react'
import { StyleSheet, View, Text } from 'react-native';
import GestureFlipView from 'react-native-gesture-flip-card';

export default function FlipCard() {
  const renderFront = () => {
    return (
      <View style={styles.frontStyle}>
        <Text style={{ fontSize: 25, color: '#fff' }}>{'Front'}</Text>
      </View>
    );
    };
    const renderBack = () => {
        return (
            <View style={styles.backStyle}>
                <Text style={{ fontSize: 25, color: '#fff' }}>{'Back'}</Text>
            </View>
        )
    }
  return (
    <View>
      <GestureFlipView width={300} height={500}>
        {renderFront()}
        {renderBack()}
      </GestureFlipView>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: 'white',
    justifyContent: 'center',
    alignItems: 'center',
  },
  frontStyle: {
    width: 300,
    height: 500,
    backgroundColor: '#f00',
    justifyContent: 'center',
    alignItems: 'center',
    borderRadius: 20,
  },
  backStyle: {
    width: 300,
    height: 500,
    backgroundColor: '#f0f',
    justifyContent: 'center',
    alignItems: 'center',
    borderRadius: 20,
  },
});
