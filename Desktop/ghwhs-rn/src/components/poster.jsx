import { ref, getDownloadURL } from 'firebase/storage';
import { useEffect, useState } from 'react';
import React from 'react';
import { View, Image, ActivityIndicator, Text, StyleSheet } from 'react-native';
import { storage } from '../data/firebase';

export default function Poster() {
    const [imgUrl, setUrl] = useState('');
    const [loading, setLoading] = useState(true);

  useEffect(() => {
      const getImageUrl = async () => {
          try {
              const storageRef = ref(storage, 'poster/poster.png');
              const url = await getDownloadURL(storageRef);
              setUrl(url);
          } catch (err) {
              console.error("이미지 다운로드에 실패했습니다: ", err);
          } finally {
              setLoading(false);
          }
      };

      getImageUrl();
  }, []);

    return (
        <View>
            {loading ? (
                <ActivityIndicator  size="large" color="#0000ff"/>
            ) : imgUrl ? (
                    <Image source={{ uri: imgUrl }} style={styles.image} />
                ) : (
                        <Text>이미지를 찾을 수 없습니다.</Text>
            )}
      </View>
  );
}
const styles = StyleSheet.create({
    image: {
        width: 200,
        height: 200
    }
});