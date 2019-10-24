import React, {Component} from 'react';
import {
  SafeAreaView,
  StyleSheet,
  ScrollView,
  View,
  Text,
  StatusBar,
  NativeModules,
  TouchableOpacity,
  UIManager,
  findNodeHandle,
  Button,
} from 'react-native';
import AdView from './AdView';

class BannerAd extends Component {
  bannerSizes = [
    "banner",
    "largeBanner",
    "mediumRectangle",
    "fullBanner",
    "leaderboard",
    "smartBannerPortrait",
    "smartBannerLandscape"
  ];
  adUnits = [
    '1001-rubicon-300x250',
    '1001-appnexus-300x250',
    '1001-300x250'
  ];
  
  state = {
    bannerSize: this.bannerSizes[0],
    adUnit: this.adUnits[0],
    isVisible: false
  };

  onLoadClicked = () => {
    this.setState({isVisible: true});
  };

  // onClick = (e) => {
  //   console.log(e.nativeEvent.bannerSize);
  //   this.setState({bannerSize: e.nativeEvent.bannerSize});
  // };

  onRefreshClicked = (propName, value) => {
    this.setState({[propName]:value});
  };

  onDestroyClicked = () => {
    this.setState({bannerSize: 'destroy'});
  };

  render() {
    const buttonView = (text, event) => (
      <View style={{alignItems: 'flex-start', flexDirection: 'row'}}>
        <TouchableOpacity style={styles.button} onPress={event}>
          <Text>{text}</Text>
        </TouchableOpacity>
      </View>
    );
    
    if (!this.state.isVisible) {
      return (
        <View style={styles.container}>
          {buttonView('Load me', this.onLoadClicked)}
          <Text style={[styles.wrapper, {backgroundColor: '#efefef'}]}>
            Ad not loaded
          </Text>
        </View>
      );
    }
    
    return (
      <View style={styles.container}>
        <View style={{flexDirection: 'row'}}>
          {buttonView('Destroy', this.onDestroyClicked)}
          {this.bannerSizes.map((item, index) => (
            <View key={item}>
              {buttonView('B ' + (index + 1), () => this.onRefreshClicked('bannerSize', item))}
            </View>
          ))}
        </View>
        <View style={{flexDirection: 'row'}}>
          {this.adUnits.map((item, index) => (
            <View key={item}>
              {buttonView('Ad ' + (index + 1), () => this.onRefreshClicked('adUnit', item))}
            </View>
          ))}
        </View>
        <AdView
          adUnit={this.state.adUnit}
          bannerSize={this.state.bannerSize}
          onClick={this.onClick}
          style={[styles.wrapper, styles.ad]}
        />
        <Text>
          {this.state.bannerSize}
          {"\n"}
          {this.state.adUnit}
        </Text>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'stretch'
  },
  ad: {
    height: 250
  },
  wrapper: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
  border: {
    borderColor: '#eee',
    borderBottomWidth: 1,
  },
  button: {
    padding: 5,
    margin: 3,
    borderColor: '#efefef',
    borderWidth: 1,
    backgroundColor: '#ddd'
  },
});

export default BannerAd;
