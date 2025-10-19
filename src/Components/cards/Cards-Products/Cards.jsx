import React from 'react';
import { PALETTE } from '../../../constants/Colors';

const Cards =() =>{
    const colorTextPrimary = PALETTE.textPrimary;
    
    return(
        <div 
            className="
                h-48 w-full 
                bg-white 
                rounded-xl 
                p-5 
                shadow-lg 
                transform hover:scale-[1.03] transition-transform duration-200 
                flex items-center justify-center
                border border-gray-100
            "
        >
            <p className='font-bold text-xl' style={{ color: colorTextPrimary }}>Producto</p>
        </div>
    )
};

export default Cards;
